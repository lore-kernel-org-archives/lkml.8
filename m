Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960DFC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE5120836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+e0zaub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgBXR3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:29:02 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46278 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbgBXR3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:29:01 -0500
Received: by mail-qk1-f194.google.com with SMTP id u124so9345577qkh.13;
        Mon, 24 Feb 2020 09:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fkrdTkaLK8LsFSzQaFmY694I4SUfdUSLTGI/jzws3rk=;
        b=V+e0zaub0CggXtFAk2QyuHHSqeqOowEm0cVWsFdYU7UeEwGcL9JGnjfbOkgOnAsX7q
         HzMiE+p3hQhuyAbQm7j3tdn9cXC7CwUbMm1mM1EW0p0nHcnW+7cZEzJ3oYd3WYKeUDyE
         RyPStmdm54SFqr1FTm1KmWbb6j2ZhYQrmYPezgrB02COTHifRGx+bZY4OnHiBUi3dJ6L
         sijV8YPmkIoV2MucDWW12TUDGdwvd0RUz9o0NHUs34fCvtakMz+lRJGuoW+eBFCU4bik
         eEXi4UbwpfqViyR4zxdzc3PmQC0b1BUK/Ib9z79eDhxlJuDlHxh/wywU6WmB+gzPJb0g
         bzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=fkrdTkaLK8LsFSzQaFmY694I4SUfdUSLTGI/jzws3rk=;
        b=Pp0sydAL2jPsD4/LZISXDyJkq/6HNSkFafRP0dmz+3/aUQ7MqLFa7CAORbdFXEbNfC
         DtVJTBSIJwYZlBcT5iJjsjWZAZ0/0rK765pDf8tMKbOZXkxpXf3mKnjyzr0N2pZxV0z0
         SrFtT//aLOo9y2yUcGPoTafEklhQ9O6wVHKgQ5pobQGSddFNG/v1WiyM0rZEZJIjFtkE
         esYmj92wlJlxg1x13EjQ773WTPzexZc5eqHqYbrtJWBHFFehSQRg9lljDakwB2PygvpF
         l+8BTpkSpYIun6+R+ssh1nyV3X7S1q64ZkHe/CR8XfCGVfNh7ByqvdGVDkdJ86UlxApx
         FGmw==
X-Gm-Message-State: APjAAAUQ1E+DPryp6n9d8YWThzPmORT2R1PRXN/AxrPWC3hu7STVI+0H
        5NQZfzdq6dmhAP73Hsci82E=
X-Google-Smtp-Source: APXvYqzIJm8JWShD8Zy/n4ceotflse8kCVF8TUswcEveWpx3d3ByuUN4vnXAeZq9HYobUdx3+lyDBg==
X-Received: by 2002:a37:4755:: with SMTP id u82mr49108164qka.43.1582565339365;
        Mon, 24 Feb 2020 09:28:59 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id q5sm6107440qkf.14.2020.02.24.09.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 09:28:59 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 24 Feb 2020 12:28:57 -0500
To:     Borislav Petkov <bp@suse.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-tip-commits@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [tip: x86/boot] x86/boot/compressed: Remove .eh_frame section
 from bzImage
Message-ID: <20200224172857.GA334627@rani.riverdale.lan>
References: <20200109150218.16544-2-nivedita@alum.mit.edu>
 <158254422067.28353.10866888120950973607.tip-bot2@tip-bot2>
 <20200224164129.GA312716@rani.riverdale.lan>
 <20200224171618.GA29636@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200224171618.GA29636@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 06:16:18PM +0100, Borislav Petkov wrote:
> On Mon, Feb 24, 2020 at 11:41:29AM -0500, Arvind Sankar wrote:
> > Hi Boris, apologies for the confusion and unnecessary work I've created,
> > but I think the preference is to merge the 2-patch series I posted
> > yesterday [1] instead of this.
> > 
> > [1] https://lore.kernel.org/lkml/20200223193715.83729-1-nivedita@alum.mit.edu/
> 
> What guarantees this would work and we won't hit some corner case or
> toolchain configuration this hasn't been tested on?
> 
> If that happens, I need to have a state to revert back to, i.e., this
> patch, discarding .eh_frame explicitly.
> 
> So I'll pick up [1] too, but give people a couple of days - a chance to
> complain about. :)
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg

Ok, note that the 2-patch series assumed that it would replace this one,
so it doesn't contain a revert of discarding .eh_frame explicitly for
the compressed kernel.

The first patch of that series at least should be safe enough, it will
stop generating .eh_frame sections in most cases, and shouldn't make any
edge cases worse than before. The second one might be a regression if we
do have some case that still creates them though.
