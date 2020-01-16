Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A02C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 12:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641DA208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 12:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="aR2p3p0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgAPM01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 07:26:27 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44679 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgAPM00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 07:26:26 -0500
Received: by mail-qk1-f196.google.com with SMTP id w127so18846379qkb.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 04:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=/urnzPsv0IxvFe95DFa8Jwmwvd6RAG7X4lrQ0EQjTks=;
        b=aR2p3p0tIqO4AAPTmoxCZB0Yxvv8qU7nIwrFb7aJ2mzeODjZiKiKzR0LwmjaakgDeo
         SMLeyNiXjZRt0viHi0OUwjE9NU8I/mCa0NVF29lSqNFO/lTTgMqueKunCFEUjnxJPNi0
         dBf2H47oLY53POThJj3uI7kiCoiPN+uSGgexH9ScmD+m/jGYNEXh/0QBIe4mW93Xl/DA
         mVXuwE1URSDqRDzKbFv9fQxgWsFDSfiWhFCJyeWncI+UcitGYbxexCtOr7nvq3BhCdpV
         228fmVw9xJEavVTi9kcH6SRZ5c9DpFFp8YqqV9urZUTAJLj4AYNBt5+AgQZMbGylsBFt
         I3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=/urnzPsv0IxvFe95DFa8Jwmwvd6RAG7X4lrQ0EQjTks=;
        b=qbseefbFG1PgBx11oWt/KK2YHx6+d/uDShIBQZFdlvOEfnfN8sVS0ACgy4QnyCVQrF
         uckiqjI3qLtjI7qOuePRqE1VIadhzxQwtzuMIstTYSNt6fVlqpDNUxyvuZO79zs49TWo
         jPA673ywPny7KpuF09BPDpyRp9dp+xn96pXLfK6ju0lqvN48NPYjK/WlA9pnOkl9VoYx
         0i+/s7L5lCGiu2Y9SYHeou5avQqK0+K92rQXQ+w8NN6Go8WqAwYerDxdbNUy8xdISsuF
         LoTHaddw6xcZWaP5vpuK0qPSPnawzmv093Uleqe7UWwzkh5hY5lOMZoWUrVEDrGUDBQU
         +u0w==
X-Gm-Message-State: APjAAAWX9NulWqXWGEglZ1gKJpSC1AXR07wc0BJYP3/cBdkPdBky1BsL
        kLDs3Bbjhq6kg+WMa4zIOU2sev17GoK2kg==
X-Google-Smtp-Source: APXvYqxTULmN7PItfxKJ378Za/ueJfSTo0KU52yMOGhl9AqvLnGubDMlaN40iobsRSmrBHFWo36HlA==
X-Received: by 2002:ae9:c317:: with SMTP id n23mr32388898qkg.356.1579177585200;
        Thu, 16 Jan 2020 04:26:25 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y18sm9879974qki.0.2020.01.16.04.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 04:26:24 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/vmscan: remove prefetch_prev_lru_page
Date:   Thu, 16 Jan 2020 07:26:23 -0500
Message-Id: <B6E75D9E-E9A2-4078-A89A-267310467B0A@lca.pw>
References: <739f4470-8dfe-bb2f-8100-2134f48868b6@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <739f4470-8dfe-bb2f-8100-2134f48868b6@linux.alibaba.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 14, 2020, at 9:33 PM, Alex Shi <alex.shi@linux.alibaba.com> wrote:
>=20
> =EF=BB=BF
>=20
>> =E5=9C=A8 2020/1/14 =E4=B8=8B=E5=8D=889:46, Qian Cai =E5=86=99=E9=81=93:
>>=20
>>=20
>>>> On Jan 14, 2020, at 7:55 AM, Alex Shi <alex.shi@linux.alibaba.com> wrot=
e:
>>>=20
>>> This macro are never used in git history. So better to remove.
>>=20
>> When removing unused thingy, it is important to figure out which commit i=
ntroduced it in the first place and Cc the relevant people in that commit.
>>=20
>=20
> Thanks fore reminder, Qian!
>=20
> This macro was introduced in 1da177e4c3f4 Linux-2.6.12-rc2, no author or c=
ommiter could be found.

Looks a bit deeper for this, and I am not sure if it is necessary to remove i=
t especially this does not cause any complication warning noise, because the=
 macro looks like a part of API design to have a pair of both read and write=
 version, even though only the write version is used at the moment.

In theory,  there could be users for the read version in the future, and the=
n it needs to be added back.=
