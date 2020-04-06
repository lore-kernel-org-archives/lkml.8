Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AFFC2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351D623105
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+/6szKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgDFPui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 11:50:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24538 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728945AbgDFPui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 11:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586188236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AiVdsmv3/2P/Q7pF5E5kmgygaZDYlx3kJKogFXNLWtA=;
        b=R+/6szKZrLlmavEi1ic8T1i4WC7miRmmBfjBCkx0xRDQFVAHxcmONrgf8vYHHkIBxe1Dhh
        Q4NTefNn8qQWsQCQC6UdAON6bIBipPtzOpREu5UFxb7Eb5h8TwKXpuyUfMcrPSMkg32Xsp
        7L8ieu/c+gY8hv14wWiiAmrb+X2XzVk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-PYxQaaAqNfepKPXUEFjMsg-1; Mon, 06 Apr 2020 11:50:34 -0400
X-MC-Unique: PYxQaaAqNfepKPXUEFjMsg-1
Received: by mail-wr1-f70.google.com with SMTP id v14so6178wrq.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 08:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AiVdsmv3/2P/Q7pF5E5kmgygaZDYlx3kJKogFXNLWtA=;
        b=rPwImEgjOZ3d6phRFdMwgX0KBi5aSjcnUjsSbrlDwE4lCi8kuEniuS/SAJTuHKaxPw
         +C6XglKDMcidn+FG+hA+zPNhSnzvmoksjI9IroZKYTok0wniyHwU/WHhC7yd+EXnUr+F
         5eBF8rVAKvUQSBK/qrafDKGxT2pTee/yHRVCS7h9fnlwEsjPWRfT645gIypbr4udAo6u
         7Hwo2KiqB6MpkWOCQfSxUm/eD2q6rYpcG/tWC4kEheTVOr8rDmaK1DngpuvoN/GBORie
         yKZBDj0wf0gvt7YjhDMJc6kFOS/iyvZVpmfK3zw6QSibdmG9TX7HPowZVoe9Y6jJqEEW
         bxaA==
X-Gm-Message-State: AGi0PuZuWS4nJ7DNoRXHYlNp8pKLFOnAqhdlH8yAQMscxBfB02rBEFyl
        OHzXWNbG84jJmSzOxEHqhcLogmYCfFOHggEb3kZlTo+BhLwJTP/lKYpzG+9diOmzPviTYSD2nkV
        fifDIviLse+g/IZNFfCWPJHrE
X-Received: by 2002:a1c:4346:: with SMTP id q67mr29832wma.162.1586188233612;
        Mon, 06 Apr 2020 08:50:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ7Gd3nZkL9uo5+Ou7XIdYwJB7yp+v4e5QytAmqs3y0Z2zBCFk8WkkT0EaCqevxA8KNcArUAA==
X-Received: by 2002:a1c:4346:: with SMTP id q67mr29819wma.162.1586188233457;
        Mon, 06 Apr 2020 08:50:33 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id y33sm12153096wrd.84.2020.04.06.08.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 08:50:32 -0700 (PDT)
Date:   Mon, 6 Apr 2020 11:50:30 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] vdpa-sim: depend on HAS_DMA
Message-ID: <20200406115000-mutt-send-email-mst@kernel.org>
References: <20200405081355.2870-1-mst@redhat.com>
 <20200406130927.GA20291@infradead.org>
 <20200406095931-mutt-send-email-mst@kernel.org>
 <0f4f2502-e810-e87a-2fba-dc887d2f4272@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f4f2502-e810-e87a-2fba-dc887d2f4272@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 10:12:56PM +0800, Jason Wang wrote:
> 
> On 2020/4/6 下午10:02, Michael S. Tsirkin wrote:
> > On Mon, Apr 06, 2020 at 06:09:27AM -0700, Christoph Hellwig wrote:
> > > Pleae just drop the code - we should not add new drivers with custom
> > > DMA ops.
> > I'm not sure there's another way to do this: this not a driver, it's a
> > software emulator that pretends to be an actual device. We can't
> > have the platform supply DMA ops here since the platform is a regular
> > x86 or whatever.
> 
> 
> Yes, actually vdpa-sim does not depends on HAS_DMA. Maybe we can do shortcut
> like dev->dma_ops = vdpasim_dma_ops;
> 
> Thanks
> 

We can do that - does it them actually work - and not just compile?

-- 
MST

