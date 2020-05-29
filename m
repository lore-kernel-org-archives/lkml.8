Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3A0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 17:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD8B820723
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 17:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Iz5G/NbY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgE2RLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 13:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2RLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 13:11:51 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1E1C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 10:11:50 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id z15so3285127pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 10:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=nGp/+75iqlq3uduDZuD3kTDOrfn+KoznVQbzyWd/W0o=;
        b=Iz5G/NbYnESBfEH6EWdVjujs8eFUmFP+RhrFVUnFccpnXv4Fa/BMMly6nTeGCYKQNz
         C8wEVN7Kny21GRz8hF5Q3DYntTnHnUP4Bb6E83XcTorLX6s0lCKByUnCXxHn0Qt87hIL
         a0Z3Hue9PxXFyB8S7an2uFhZkyhX47Ewf9Ct5tsdtdhtUH/nsbizxhYF19tREa6fIVtT
         PpeK7rJJcszGtoMaiZGWrzO1cp53RsPAYS3GNy93jxWxzsXT1QDnoq9MV/++bGm12YKg
         NEwfwlYSkboqITa2pkQa+0WBMg4DtDLrqQhTq2xfBYHBfSCvwkzHMejnXMDnUP6al0IK
         Eq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=nGp/+75iqlq3uduDZuD3kTDOrfn+KoznVQbzyWd/W0o=;
        b=UIkYnzPSun6IB6aQ9HGmW2+pOi44RWyPOnn/PfqHQAvGOGN3daSAVC7J8h29F3Tx6h
         +17l9o0UMykz2RNzSwTIXrQkC+EQ1AzFcnpBELk9P2Id4Alq/r64DVhY8e7gcmkI8zp1
         uKtTzmGNe07YPvJ3PU4B+s3cW4J8zkX6iqQJTpoUc4axXgDCI7I5rfNynsEWg8FCUifN
         jIxDHDv/qHHVo8yxgBty7Q+9DwTgOEoqSHHmNx/dEEb7ij5LNmJUiZoTFhR3xvDwdsfD
         Br26C+u6OgGGmTbBio/97bocl/G2otVoC7kabs6BSRYE9UXKAB90IMIbIyu+VITJlLj+
         o5VA==
X-Gm-Message-State: AOAM530B53S+wjEaJAfJ5cuY0qXTOuKyBNDhOu7LiJpomQ2kPCJ+pfyW
        cT+dWMGZ0GRVshCtDaAqoDK1Fw==
X-Google-Smtp-Source: ABdhPJxU7IET/hCFPb/sQTpkd+UhssO24dR0raJ+KxqwUUO0QOtBkWnqsfO01aR/A7zGCXOYcrsdlw==
X-Received: by 2002:a17:90a:9c6:: with SMTP id 64mr10932757pjo.83.1590772309919;
        Fri, 29 May 2020 10:11:49 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:2dc1:c1e9:9ff7:54d4? ([2601:646:c200:1ef2:2dc1:c1e9:9ff7:54d4])
        by smtp.gmail.com with ESMTPSA id n8sm32418pjq.49.2020.05.29.10.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 10:11:48 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [BOOTLOADER SPECIFICATION RFC] The bootloader log format for TrenchBoot and others
Date:   Fri, 29 May 2020 10:11:40 -0700
Message-Id: <7FE0DF48-C221-460E-99D5-00E42128283C@amacapital.net>
References: <20200529112735.qln44ds6z7djheof@tomti.i.net-space.pl>
Cc:     grub-devel@gnu.org, linux-kernel@vger.kernel.org,
        trenchboot-devel@googlegroups.com, x86@kernel.org,
        xen-devel@lists.xenproject.org, alec.brown@oracle.com,
        alexander.burmashev@oracle.com, andrew.cooper3@citrix.com,
        ard.biesheuvel@linaro.org, dpsmith@apertussolutions.com,
        eric.snowberg@oracle.com, hpa@zytor.com, javierm@redhat.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        krystian.hebel@3mdeb.com, leif@nuviainc.com,
        lukasz.hawrylko@linux.intel.com, michal.zygowski@3mdeb.com,
        mjg59@google.com, mtottenh@akamai.com, phcoder@gmail.com,
        piotr.krol@3mdeb.com, pjones@redhat.com, ross.philipson@oracle.com
In-Reply-To: <20200529112735.qln44ds6z7djheof@tomti.i.net-space.pl>
To:     Daniel Kiper <daniel.kiper@oracle.com>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 29, 2020, at 4:30 AM, Daniel Kiper <daniel.kiper@oracle.com> wrote:=

>=20
> =EF=BB=BFHey,
>=20
> Below you can find my rough idea of the bootloader log format which is
> generic thing but initially will be used for TrenchBoot work. I discussed
> this proposal with Ross and Daniel S. So, the idea went through initial
> sanitization. Now I would like to take feedback from other folks too.
> So, please take a look and complain...

> In general we want to pass the messages produced by the bootloader to the O=
S
> kernel and finally to the userspace for further processing and analysis. B=
elow
> is the description of the structures which will be used for this thing.

Is the intent for a human to read these, or to get them into the system log f=
ile, or are they intended to actually change the behavior of the system?

IOW, what is this for?=
