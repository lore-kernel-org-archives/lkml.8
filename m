Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75D0C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818C32465A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="KmITXcZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgANRbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:31:07 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36370 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbgANRbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:31:07 -0500
Received: by mail-qt1-f196.google.com with SMTP id i13so13164780qtr.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 09:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=St8u8FHo8VDNQhqovRVh1AEgg+/3cFOh49eIYTEBzOA=;
        b=KmITXcZxS4p4wtILg0kSu5+Q6s914wx0sh4RpeA8OW+jjWbd4bH7wyOZKSASZOcLcF
         gHf1IkT8rWqxLcWvZWox26Uh5NPyVZ4YfpNLRbWw2LzvOVgTh7MJ/n41AP/KAz4ZD5Q8
         BlUTg92fI4wjTjAFbjLHrAlrOjZ45R2mcKQYMp2ddf1z5pNzgdWNbIReGgIADIXojx6y
         v+NlpEbuipbRZrYrkqN/DHK+W+xKJxaIIkRb2/whNeMQWzak5bsZvb07HPuiWE7M8OB/
         CaCM65yHWKR4wbwqjTavSnDzl76xVhG8DrKbAuzkZeXD9O+XZ6MmXR9A5wvwwYHQF0qS
         mQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=St8u8FHo8VDNQhqovRVh1AEgg+/3cFOh49eIYTEBzOA=;
        b=fb02FYS+ZXfXFtlwcrzZ7JHo1W9iBzHmVEAB04OpuADsYy+AjLh/Q1P0vEFe1zKRkH
         C7eTPh22SNy7V5G1TTcoJQjPD3li1ljGY5RsX7eIT1DSjNKJlXM/yZx03YLnqkByIW6D
         fCwaIF661ss3UzrA0cjYotbHN+n+8iiqWsmYc7t91UZwU6DODFQDstQPGdCMERc+tDcd
         m0zefNghwZFZG0+82ad+mKCPnpfYkcsXtlvNChaQon8J8OazPHYx2GAnR890SVkOx234
         qAzKgdkWa0DD0MkBUPtSNF0ghockHGh5q9H7qT3wJg12hkfVRCmQakKGq3ALaRY2rFEe
         2n+g==
X-Gm-Message-State: APjAAAUMFTwnfvb1kLXFY0p3KN1WYB6euFpID/59BCGYrtTIF7cHI/CK
        Tf4QTuEqlbye9Bu8MbOs73W4Og==
X-Google-Smtp-Source: APXvYqy1//b/irP1NAsyHKlgVn2OQv5aVwXISbM+nbSM7GAcVl3KkEqjAbpA+LmhLCr4ZR199oyePQ==
X-Received: by 2002:ac8:478a:: with SMTP id k10mr4603821qtq.260.1579023066141;
        Tue, 14 Jan 2020 09:31:06 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id g18sm8046403qtc.83.2020.01.14.09.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jan 2020 09:31:05 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: linux-next: Signed-off-by missing for commit in the random tree
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200114165739.GB140865@mit.edu>
Date:   Tue, 14 Jan 2020 12:31:04 -0500
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <613F42EB-F993-4F39-AD9B-A86E06A875AA@lca.pw>
References: <20200108113953.1a92a90f@canb.auug.org.au>
 <20200114001832.GP76141@mit.edu> <20200114012221.GC202391@google.com>
 <20200114165739.GB140865@mit.edu>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 14, 2020, at 11:57 AM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>=20
> On Tue, Jan 14, 2020 at 10:22:21AM +0900, Sergey Senozhatsky wrote:
>>=20
>> Oh, I didn't realize I was the author. Sorry!
>>=20
>> Sure, confirmed
>>=20
>> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
>>=20
>=20
> Hmm... the e-mail in question[1] was sent by Qian Cai, but there was a
>=20
>   From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
>=20
> in the first line of the body which attributed the patch to you.  But
> then e-mail continues:
>=20
>   Sergey didn't like the locking order .... but those code is so old,
>   and I have no clue how to de-couple it after checking other locks in
>   the splat. There is an onging effort to make all printk() as =
deferred,
>   so until that happens, workaround it for now as a short-term fix.
>=20
> So did Qian Cai author the patch, and this should have been
> "Reported-by Sergey Senozhatsky"?  In which case I need a
> Signed-off-by from Qian Cai.
>=20
> This is a pretty trivial patch, but it would be good to get the
> attributions and credit correct!
>=20
> 						- Ted
>=20
> [1] =
https://lore.kernel.org/linux-arm-kernel/1573679785-21068-1-git-send-email=
-cai@lca.pw/

It is actually Sergey proposed an informal patch here [1]. I just sent =
on
his behave and adding a commit log.

[1] https://lore.kernel.org/linux-mm/20190911011008.GA4420@jagdpanzerIV/=20=


