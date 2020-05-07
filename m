Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488B8C54E49
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24A90206B9
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588886050;
	bh=nDy0sEtP9kF9L34Jo/5G/mMWigMW2hNi5uXvTqim0pM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i9yIdDq6i7ohiTL7KdAZ8278uWlaI5iM/vw/z/WJMste7OjWeXkNZzhz3RwkJJEP9
	 NnnV1j65CggI8OsRoLrAJegBLy5lxAgMQg2ulEp2McYz9fIUf2XHcbSuzn9ZcV5TfZ
	 IA7t6EvRb/WiGBSV2GlCqVFd8qlzPFwjQI2/2odg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgEGVOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 17:14:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbgEGVOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 17:14:09 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 082C420731;
        Thu,  7 May 2020 21:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588886048;
        bh=nDy0sEtP9kF9L34Jo/5G/mMWigMW2hNi5uXvTqim0pM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a2yUU+AIANQ4UaVmmqQneT/ArIvzOWURsUBdTfPSmBKjwPw+HrkXe9ThyjNY1zx7T
         wLzdjKBW93PQ3BjJqvczVnRV0QVXUlCQlx2oxMz1uylAjh8xnFCxK3XcLUOCcXsWK5
         84Y+HmMrGOCmL7pA2V+b3gyWOO8tX99O+9yyD5J4=
Date:   Thu, 7 May 2020 16:18:34 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: venus: Replace zero-length array with
 flexible-array
Message-ID: <20200507211834.GA20715@embeddedor>
References: <20200507190750.GA15755@embeddedor>
 <a249b3b7-56dc-8bed-f079-2cf163b46712@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a249b3b7-56dc-8bed-f079-2cf163b46712@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 11:39:51PM +0300, Stanimir Varbanov wrote:
> Hi Gustavo,
> 
> Two patches from you are already queued in media_tree for v5.8.
> 

Awesome. :)

Thanks, Stanimir.
--
Gustavo

> 0f61e171e4bbac4595175070c75707f1b12f4e37 media: venus: hfi_msgs.h:
> Replace zero-length array with flexible-array member
> 
> 380f3bbd9562dc93be2e3cadc329b15284fbedae media: venus: hfi_cmds.h:
> Replace zero-length array with flexible-array member
> 
> 
> On 5/7/20 10:07 PM, Gustavo A. R. Silva wrote:
> > The current codebase makes use of the zero-length array language
> > extension to the C90 standard, but the preferred mechanism to declare
> > variable-length types such as these ones is a flexible array member[1][2],
> > introduced in C99:
> > 
> > struct foo {
> >         int stuff;
> >         struct boo array[];
> > };
> > 
> > By making use of the mechanism above, we will get a compiler warning
> > in case the flexible array does not occur last in the structure, which
> > will help us prevent some kind of undefined behavior bugs from being
> > inadvertently introduced[3] to the codebase from now on.
> > 
> > Also, notice that, dynamic memory allocations won't be affected by
> > this change:
> > 
> > "Flexible array members have incomplete type, and so the sizeof operator
> > may not be applied. As a quirk of the original implementation of
> > zero-length arrays, sizeof evaluates to zero."[1]
> > 
> > sizeof(flexible-array-member) triggers a warning because flexible array
> > members have incomplete type[1]. There are some instances of code in
> > which the sizeof operator is being incorrectly/erroneously applied to
> > zero-length arrays and the result is zero. Such instances may be hiding
> > some bugs. So, this work (flexible-array member conversions) will also
> > help to get completely rid of those sorts of issues.
> > 
> > This issue was found with the help of Coccinelle.
> > 
> > [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> > [2] https://github.com/KSPP/linux/issues/21
> > [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  drivers/media/platform/qcom/venus/hfi_cmds.h |    2 +-
> >  drivers/media/platform/qcom/venus/hfi_msgs.h |   10 +++++-----
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
> > index cae9d5d61c0c..83705e237f1c 100644
> > --- a/drivers/media/platform/qcom/venus/hfi_cmds.h
> > +++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
> > @@ -107,7 +107,7 @@ struct hfi_session_abort_pkt {
> >  struct hfi_session_set_property_pkt {
> >  	struct hfi_session_hdr_pkt shdr;
> >  	u32 num_properties;
> > -	u32 data[0];
> > +	u32 data[];
> >  };
> >  
> >  struct hfi_session_set_buffers_pkt {
> > diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.h b/drivers/media/platform/qcom/venus/hfi_msgs.h
> > index 7694b1d25d9d..526d9f5b487b 100644
> > --- a/drivers/media/platform/qcom/venus/hfi_msgs.h
> > +++ b/drivers/media/platform/qcom/venus/hfi_msgs.h
> > @@ -155,7 +155,7 @@ struct hfi_msg_session_empty_buffer_done_pkt {
> >  	u32 input_tag;
> >  	u32 packet_buffer;
> >  	u32 extradata_buffer;
> > -	u32 data[0];
> > +	u32 data[];
> >  };
> >  
> >  struct hfi_msg_session_fbd_compressed_pkt {
> > @@ -175,7 +175,7 @@ struct hfi_msg_session_fbd_compressed_pkt {
> >  	u32 picture_type;
> >  	u32 packet_buffer;
> >  	u32 extradata_buffer;
> > -	u32 data[0];
> > +	u32 data[];
> >  };
> >  
> >  struct hfi_msg_session_fbd_uncompressed_plane0_pkt {
> > @@ -202,7 +202,7 @@ struct hfi_msg_session_fbd_uncompressed_plane0_pkt {
> >  	u32 picture_type;
> >  	u32 packet_buffer;
> >  	u32 extradata_buffer;
> > -	u32 data[0];
> > +	u32 data[];
> >  };
> >  
> >  struct hfi_msg_session_fbd_uncompressed_plane1_pkt {
> > @@ -211,7 +211,7 @@ struct hfi_msg_session_fbd_uncompressed_plane1_pkt {
> >  	u32 filled_len;
> >  	u32 offset;
> >  	u32 packet_buffer2;
> > -	u32 data[0];
> > +	u32 data[];
> >  };
> >  
> >  struct hfi_msg_session_fbd_uncompressed_plane2_pkt {
> > @@ -220,7 +220,7 @@ struct hfi_msg_session_fbd_uncompressed_plane2_pkt {
> >  	u32 filled_len;
> >  	u32 offset;
> >  	u32 packet_buffer3;
> > -	u32 data[0];
> > +	u32 data[];
> >  };
> >  
> >  struct hfi_msg_session_parse_sequence_header_done_pkt {
> > 
> 
> -- 
> regards,
> Stan
