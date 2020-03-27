Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62F3C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA73220714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMXR49li"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgC0USG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 16:18:06 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36338 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgC0USG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 16:18:06 -0400
Received: by mail-qk1-f195.google.com with SMTP id d11so12266504qko.3;
        Fri, 27 Mar 2020 13:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=fdLNdb5vV7EWBwBJsTA02I7SN8YRstMDrVYyf+Epleo=;
        b=WMXR49li9M7Ay/LAuIp7iTl5rR1hyhKjZ5OrKJVyHj8W7jANVttmZmv+Iawqe6HmyD
         ntJqVpjPPqgv0YMNEfyavZl/8DJBb3qLypEW8QrxCpqtzoSf/RTVK4FDgV5wBP7CYIqI
         i8YAFQNWn/PrnneW/R3l9zwOX0DF28+yec+f4S25tqVycMK7yinntCwwVlhrF/eievMZ
         TR4ljKc+5fHXxfb1Do0HhMx2e3Q6885T5p9EE4TKXRPyEEczvkVBYGeGxcZEYVEdFAnM
         LuttGJD1+TF6RQSN3deTmN4cwtO8PC4CXc67gtgwg/rSnPRC8J7Fk8XLcdrBqqJ9nuTP
         5npg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=fdLNdb5vV7EWBwBJsTA02I7SN8YRstMDrVYyf+Epleo=;
        b=drxflpaUtra9mHBkQlgi0c0HAtriOwuuw4yl2B94UbdGGXcOHddAVp0lBOHpxs00im
         p9uBBcFhEfEpegSGpWyvfH2QqcJmb/rvDLkDRLfqLDhKvqx7+SmdNMgr3RhHNWCE1pvZ
         8iZuHBkmq+TsBkgfgJH+Dq4udeGXEF3I73RHOG+3XgzbxAMQ65IyWaKLNxcEnkcGTa7U
         iXpHjOj53abPfnS+6UUUn1gPDQEHQoC2quN8QxqBrQT52KmTm1Mv1iUsMECvkWLjDIYp
         60HpY1DU5Sk2pdhdGFbU1jx7FQRjIw6tLtTK1JAm0mKGfgfXSVqjrHJPtfGoXqriIIm/
         7Dig==
X-Gm-Message-State: ANhLgQ1w3rZzZYSmJbsE1uWR9rLUCJcKeuzikf2u7bKsWBgLDq952A4k
        7bGMDwgt+rnvfwMu4te8Nwo=
X-Google-Smtp-Source: ADFU+vupWQpU49uhSO2qQ2kq0HhGX9du0eRtWuURO+dI/slhPNScZZ1YzEwHDlg/NgWE7xxDWBoILA==
X-Received: by 2002:a05:620a:204f:: with SMTP id d15mr1109913qka.259.1585340284945;
        Fri, 27 Mar 2020 13:18:04 -0700 (PDT)
Received: from [192.168.86.185] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id j20sm4560987qke.44.2020.03.27.13.18.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Mar 2020 13:18:04 -0700 (PDT)
Date:   Fri, 27 Mar 2020 17:17:59 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <20200327200934.GB2715@suse.de>
References: <20200325164053.10177-1-tonyj@suse.de> <38ba2caa-dadd-52c4-c6ea-5e01b7e59ee2@us.ibm.com> <20200327200934.GB2715@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] perf tools: update docs regarding kernel/user space unwinding
To:     Tony Jones <tonyj@suse.de>
CC:     linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
From:   Arnaldo Melo <arnaldo.melo@gmail.com>
Message-ID: <C8021C4E-2764-47CE-AF79-10823C7FDBB2@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On March 27, 2020 5:09:34 PM GMT-03:00, Tony Jones <tonyj@suse=2Ede> wrote=
:
>On Thu, Mar 26, 2020 at 04:32:26PM -0500, Paul Clarke wrote:
>> > +		and 'lbr'=2E  The value 'dwarf' is effective only if libunwind
>> > +		(or a recent version of libdw) is present on the system;
>> > +		the value 'lbr' only works for certain cpus=2E The method for
>> > +		kernel space is controlled not by this option but by the
>> > +		kernel config (CONFIG_UNWINDER_*)=2E
>>=20
>> Your changes are just copying the old text, so this isn't a criticism
>of your patches=2E
>>=20
>> Do we have information to replace "a recent version of libdw", which
>will quickly get stale?
>
>Hi Paul=2E
>
>The original "(libunwind or a recent version of libdw)" text was from
>Feb 2016=2E   So a while ago=2E

Unfortunate wording, would be better to have the version where the require=
d feature was added to libdw=2E

>
>bd0419e2a5a9f requires >=3D 0=2E157 but this is for probing=2E  0a4f2b6a3=
ba50
>specifies >=3D 0=2E158 but I see no mention of=20
>why in the commit but since it's from 2014 and elfutils is now at
>0=2E178,  I think it's safe to just remove the=20
>reference=2E
>
>As an aside, there is a lot of detail in perf-config=2Etxt that's
>available in some of the other subcomands help files=2E
>Seems a good way for things to get stale=2E   It could also do with some
>grammatical cleanup=2E

English as a second language, many contributors, please consider sending f=
ixes, would be really appreciated,

Thanks,

- Arnaldo
>
>Tony

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
