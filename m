Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F67C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CD3920738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbgGMNHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 09:07:54 -0400
Received: from foss.arm.com ([217.140.110.172]:33504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729523AbgGMNHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:07:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7C7630E;
        Mon, 13 Jul 2020 06:07:52 -0700 (PDT)
Received: from e119603-lin.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF5443F887;
        Mon, 13 Jul 2020 06:07:51 -0700 (PDT)
Date:   Mon, 13 Jul 2020 14:07:49 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        arnd@arndb.de, sudeep.holla@arm.com
Subject: Re: [PATCH 2/3] firmware: arm_scmi: Remove unneeded __packed
 attribute
Message-ID: <20200713130749.GA31938@e119603-lin.cambridge.arm.com>
References: <20200710133919.39792-1-cristian.marussi@arm.com>
 <20200710133919.39792-2-cristian.marussi@arm.com>
 <751ee628-ff38-a383-5832-aab4905af32b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <751ee628-ff38-a383-5832-aab4905af32b@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven

thanks for the review.

On Mon, Jul 13, 2020 at 12:20:43PM +0100, Steven Price wrote:
> On 10/07/2020 14:39, Cristian Marussi wrote:
> >Remove __packed attribute from struct scmi_event_header.
> >
> >Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> 
> A drive-by review. But this doesn't look safe to me. sizeof(struct
> scmi_event_header) is used in several places and this change will modify
> that from 13 to 16, but leave the structure members at the same offset (as
> the members are naturally aligned). In particular the naïve header size is
> now bigger than the offset to payld.
> 
> What is the justification for __packed being 'unneeded'?
> 

Arnd pointed out at first that this structure in the original series had a mix of
fixed and non-fixed types in its fields and that the __packed rendered some fields
misaglined.

Removing that as it is, in fact left also some unexplained implicit padding which is
at odd for a struct containing fixed-sized types.

In a following fix in the series I have indeed moved this struct's fields  and others
to generic non fixed type fields and shuffled around the fields to avoid misalignment
and implicit internal padding (except for the trailing padding due to the variable
size array)

It was probably better to squash also this patch in that following patch.

This structure is used internally to push variable-sized (through the means of the payld[])
events descriptors through a fifo from the ISR to the deferred workqueus, so that's whhy I
originally thought to avoid to carry around unneeded padding into the fifos and use the
__packed.

On the correctness side, as you pointed out, the header with padding is now 16 so when
I push thorugh the kfifos this header and the payload there's a hole in the data as
represented in the fifo buffer as such

@end_of hdr+payld kfifo writes:
  kifo_in(fifo, h, sizeof(*h)) + kfifo_in(fifo, payld, h->payld_sz)

0       14   16
+-------+----+------------
|header - pad| payload...
-------------------------
        ^
	|
	.payld

(Note that header and payload comes from two distinct place so I have push it with two kfifo_in()
in order to avoid a redundant memcpy on an intermediate buffer to collate them...thing
that was pointed out as undesirable in a review)

and when I read it back from the fifo such hole is just transparently overwritten:

@header read:
 kfifo_out(fifo, h, sizeof(*h))

0       14   16
+-------+----+--------------
|header - pad| 
----------------------------

@payload_read:
 kfifo_out(fifo, h->payld, h->payld_sz)

0       14   
+-------+----+--------------
|header | payload....
----------------------------
        ^
	|
	.payld

So since anyway the drawback of packing is that the misaglined access potentially slows down the
reads, I was not sure anymore it was worth to pack and misalign, and, given that it seemed not
to be liked so much, I dropped it and moved to generic non-fixed types without packing.

A better (and shorter) explanation of all of the above is possibly needed (but I'd still prefer
the fixed sized typing and __packed 'holeless' approach...)

Thanks

Cristian


> Steve
> 
> >---
> >  drivers/firmware/arm_scmi/notify.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
> >index c4d006cfde88..752415367305 100644
> >--- a/drivers/firmware/arm_scmi/notify.c
> >+++ b/drivers/firmware/arm_scmi/notify.c
> >@@ -258,7 +258,7 @@ struct scmi_event_header {
> >  	u8	evt_id;
> >  	size_t	payld_sz;
> >  	u8	payld[];
> >-} __packed;
> >+};
> >  struct scmi_registered_event;
> >
> 
