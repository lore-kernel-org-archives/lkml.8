Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30005C2D0F7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 20:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02C5920753
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 20:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="H5iBBvNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731167AbgELUHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 16:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELUHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 16:07:52 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C631EC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 13:07:52 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x13so1002015pfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 13:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=rhtiEIBdzrHkDBisACwiSoBSZLTSxhAWeD0kG6AJCFU=;
        b=H5iBBvNakTJBq65S0nZntk6pa2kBI14r+JX5VeLNl0q/aSIb/oOQ5cr3B5ryhwWmRJ
         Qv5/d2wU1pzVzv+HpZXfwy4Il/mtIWoxr8hE6LRJ+3uD13CSwrYAQmP3CST8spjPid1g
         DbEQl/LlxgyBbFP2WkWeDCbufGZoDefL3Lgrh7iOORUEnZ1MWFSxG0WIYT8ZbZrDRRNM
         24SAphwjXWQjnh72iqX+TLs4r9HVZe2WEXV9145cVwrnl5mSmCzFTDOe9o6QDbmSzE0R
         gc6C1T6ILCw0YUviirEtZPUWm3Ey/XSn9yVSH4YZGqM/2TV+ylRvb8iwgkEctkcbcmoa
         Cj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=rhtiEIBdzrHkDBisACwiSoBSZLTSxhAWeD0kG6AJCFU=;
        b=maZnpOoMPxQtRCBV9cjZLtAcMMlNmEeMUZkHN4cHtEsZZy6CWrM/6cZX3QSKCf7Or8
         cttE9NzGkNGVtmoGWzvfGCg8TYA0piP6vbpijmirkUNEUWbcdLg46CzbSLSdTTUUUpky
         Fapith9/7FnqF7r1AF7aFlBS2d6HD+JC/bdt0NujQt6DqJe3etNfbnZksCDbWO8RXyKG
         M0ZHo7jCwUqsVMtDvVMqk0eQhKwnF8u2ZWbhIEC7OOXTMGKoPfnCJpbLWtE2kLTdDueL
         nxT7tTIN8m8SfCGefqHdSQnCv8ZxVfA2/LHPEUmgD8UpdFpzDN1D+q/IN1+eLXH+0hbm
         aUkw==
X-Gm-Message-State: AOAM532CHU/d7FsvLcuuQZzK99xjt4sj4epglmbLRylBhSM10X23JgqM
        Eqw9/Ret5V+kw3QYxkiOSpqcVw==
X-Google-Smtp-Source: ABdhPJwYVudVGNEQY4Il1qQDZHj/08latFnDIYDe8ER9Rqo1bss5a2rLcmgYlaAvcJbIK4Yv5CGZ9g==
X-Received: by 2002:a63:c04a:: with SMTP id z10mr8395941pgi.430.1589314072335;
        Tue, 12 May 2020 13:07:52 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:a93f:12ed:b744:bd73? ([2601:646:c200:1ef2:a93f:12ed:b744:bd73])
        by smtp.gmail.com with ESMTPSA id x132sm12819152pfc.57.2020.05.12.13.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 13:07:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC v4][PATCH part-1 0/7] ASI - Part I (ASI Infrastructure and PTI)
Date:   Tue, 12 May 2020 13:07:28 -0700
Message-Id: <7F322031-034E-4B36-A60F-663EAA4C99C9@amacapital.net>
References: <a65d6cbf-41de-3001-6792-21a4233d8467@intel.com>
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com
In-Reply-To: <a65d6cbf-41de-3001-6792-21a4233d8467@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On May 12, 2020, at 10:45 AM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
> =EF=BB=BFOn 5/4/20 7:49 AM, Alexandre Chartre wrote:
>> This version 4 of the kernel Address Space Isolation (ASI) RFC. I have
>> broken it down into three distinct parts:
>>=20
>> - Part I: ASI Infrastructure and PTI (this part)
>> - Part II: Decorated Page-Table
>> - Part III: ASI Test Driver and CLI
>>=20
>> Part I is similar to RFCv3 [3] with some small bug fixes. Parts II and II=
I
>> extend the initial patchset: part II introduces decorated page-table in
>> order to provide convenient page-table management functions, and part III=

>> provides a driver and CLI for testing ASI (using parts I and II).
>=20
> These look interesting.  I haven't found any holes in your methods,
> although the interrupt depth tracking worries me a bit.  I tried and
> failed to do a similar thing with PTI in the NMI path, but you might
> have just bested me there. :)
>=20
> It's very interesting that you've been able to implement PTI underneath
> all of this, and the "test driver" is really entertaining!
>=20
> That said, this is working in some of the nastiest corners of the x86
> code and this is going to take quite an investment to get reviewed.  I'm
> not *quite* sure it's all worth it.
>=20
> So, this isn't being ignored, I'm just not quite sure what to do with
> it, yet.

I=E2=80=99m going to wait until the dust settles on tglx=E2=80=99s big entry=
 rework before I look at this.=
