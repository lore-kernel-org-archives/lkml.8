Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD06EC2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 17:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7B120771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 17:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nZIVGBc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgDGRsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 13:48:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36058 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgDGRsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 13:48:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id n10so1140981pff.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 10:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NC51PyoeamQkUwNgNNp8H/PX+EtaFEIUJWMw1TZOgI8=;
        b=nZIVGBc4jmA4lzk0Zkn7WALd70Xd5qFDNwJxNppCL9xq1otHq76X/b0bXcWGG6I5bP
         KVMETgaTH6b21yCO5T4HZu/i/h9PCNi7OnQdgXMl0w+EbVE7vwuxpvV2JykIHuhSjeZI
         KTpgwFZ+6nU8HQSi0sFOyKKBCeSym/YN1wsxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NC51PyoeamQkUwNgNNp8H/PX+EtaFEIUJWMw1TZOgI8=;
        b=ZCO86iR4FOSGdfXDmdDolJ9DNrNL31FCV7rPgRPJESEiCoafVtPBtnMbj7gx4s+PwX
         2KHWoUWdTt53HikkfErdSu2T7bc0x2UwSOpX9EIMaqrOCBESQRGN+a52tl5xW93GSF7Z
         1v6c1GUJ3ktC7BEhbeMVEWx4l6nT1PJ8KyB3mHTuoSLgZWSSue+AMKYKkUZzwVn06/Rl
         6ki+BUn9vEpaMtdAdqkXAxUZKSbRhYkcF9gbjj4FJmL/19JOCyyqgd7JaTlcEhSJUnee
         Aulsok2PW4pYBrEx7iOcAnHRtVgboGX53cLW6ZOgOlyBdPIXH3JowhO2pdoewLxRUq+y
         ZA+Q==
X-Gm-Message-State: AGi0PuZICberWjWgZOD+Cr9iF92o5eKGvuxVZRNfgbu3ClNj/gYPgf0D
        Ebt0JuDU4rXNgkttTNVYxmbR2Q==
X-Google-Smtp-Source: APiQypI25g0jV1NZvt8ma29F7Vt2lnrWAbATkwBHXyull3NZyvOgwZ2gvZdTN+f9ALFqpzAbFfOswg==
X-Received: by 2002:a63:6d4a:: with SMTP id i71mr2545924pgc.445.1586281694084;
        Tue, 07 Apr 2020 10:48:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c14sm1696086pgi.54.2020.04.07.10.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 10:48:13 -0700 (PDT)
Date:   Tue, 7 Apr 2020 10:48:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Fr=E9d=E9ric?= Pierret 
        <frederic.pierret@qubes-os.org>
Cc:     re.emese@gmail.com, kernel-hardening@lists.openwall.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc-common.h: 'params.h' has been dropped in GCC10
Message-ID: <202004071044.0B773CCB4B@keescook>
References: <20200407113259.270172-1-frederic.pierret@qubes-os.org>
 <202004070945.D6E095F7@keescook>
 <3119553b-49dc-9d88-158f-2665f56f7b5c@qubes-os.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3119553b-49dc-9d88-158f-2665f56f7b5c@qubes-os.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 07:22:55PM +0200, Frédéric Pierret wrote:
> 
> 
> On 2020-04-07 18:45, Kees Cook wrote:
> > 
> > Hi! Thanks for the patch. I don't think this is a hack: it's the right
> > thing to do here, yes? GCC 10 includes this helper in gimple.h, so we
> > can ifdef it out in gcc-common.h.
> > 
> > -Kees
> Hi Kees,
> Thank you very much for your comment. Would you like me to rephrase the commit including your comment too? "Hacky" mostly meaning humble modification from my point of view :)

Heh, no worries. I've just reproduced the failure you found with gcc 10,
and I've updated your commit log (and added -Wno-format-diag to the plug
builds). Here's what I've got in my tree now:
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=for-next/gcc-plugins&id=dda632f1bc6da784baab8069e26547e3f4144dbe

Thanks for the patch!

-Kees

-- 
Kees Cook
