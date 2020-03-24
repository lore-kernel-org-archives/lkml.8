Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B22C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF81620719
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgCXKRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:17:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47174 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbgCXKRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:17:14 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id B237B2968B2
Message-ID: <1187a3f660b092d8a9d5437445155edfc0744a4f.camel@collabora.com>
Subject: Re: [PATCHv4 04/11] videobuf2: add queue memory consistency
 parameter
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Helen Koike <helen.koike@collabora.com>,
        nicolas.dufresne@collabora.co.uk
Date:   Tue, 24 Mar 2020 07:17:01 -0300
In-Reply-To: <20200324023909.GA201720@google.com>
References: <20200302041213.27662-1-senozhatsky@chromium.org>
         <20200302041213.27662-5-senozhatsky@chromium.org>
         <6e4fc7f9-0068-92ff-77d7-9c77c047f3db@collabora.com>
         <20200324023909.GA201720@google.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-24 at 11:39 +0900, Sergey Senozhatsky wrote:
> On (20/03/20 14:46), Dafna Hirschfeld wrote:
> [..]
> > > +static void set_queue_consistency(struct vb2_queue *q, bool consistent_mem)
> > > +{
> > > +	if (!vb2_queue_allows_cache_hints(q))
> > > +		return;
> > > +
> > > +	if (consistent_mem)
> > > +		q->dma_attrs &= ~DMA_ATTR_NON_CONSISTENT;
> > > +	else
> > > +		q->dma_attrs |= DMA_ATTR_NON_CONSISTENT;
> > > +}
> > > +
> > >   int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
> > > -		unsigned int *count)
> > > +		bool consistent_mem, unsigned int *count)
> > You extended the vb2_core_reqbufs accepting a new boolean that
> > is decided according to the setting of the V4L2_FLAG_MEMORY_NON_CONSISTENT
> > but in the future some other flags might be added, and so I think it
> > is better to replace the boolean with a u32 consisting of all the flags.
> 
> Don't have any objections. Can change the `bool' to `u32'.
> 

or maybe an enum instead? That would help get a cleaner
interface.

Thanks,
Ezequiel

