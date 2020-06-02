Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E704C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 00:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEBCA20674
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 00:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="ndyJivol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgFBAtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 20:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgFBAtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 20:49:08 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7757C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 17:49:07 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w68so3445478pfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 17:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=6DuNPAr1idaRpwQ6WcJVhQL920mjQAymmj650iV94eU=;
        b=ndyJivolQhyu2G6jZDIL/3xVQMu7J5dCWIi8tQ/LjVvOwidJUN8YvCAT0/yuqk2SYn
         R4nZnux60kel9RdDMcg9ElcTdIBIKVsMFEVXLh6Cd8nv1K7YkJAPlZrGIj9VPCGHiqUw
         dMFHYBHgHuD1VjhfkClysZHfdh/5YndQ0eZ9FmVGMvZJ0qhjbOm8Sixdn5CxrUUh7Pmj
         FQWkh0mrQY541Kp7+1Szbp7whjwhMeTbVABof07h8P15E6dOJavDM+ozdvQ+v8EhU8eY
         lCWi/i8QKhQ3gYmlrx19jXmtp/mFfUsTBahzCXKpq1nfwCU3siOU577JZi9f7VTy7e2Z
         +EYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=6DuNPAr1idaRpwQ6WcJVhQL920mjQAymmj650iV94eU=;
        b=jUoa0OenbLcnbTQE7gexbdHRz8E8J2ShsB6bJfyz2EvTV0fQ+BWXtO1fGEj7+2O6HC
         ofep+e93BKSprsWFm8HTLdDhEOe50btIBGwg/maTWjQ3/6UzN4VH7GUsEEKLZXDd87pr
         6quECqYEnSggLOmNG6iwId+TnioYk0lPWN9NuOsNXFiUsm0qedJ3FaguDc1JbaPv/3Em
         vfkcBSRPnYTgdWQZNMqCEkYKpNhJQxZL3yHm5NDVqkk75AOshhfSziMzXF+dHFrXsYJd
         zqFzPk3wjsUwTNrEjSbDOd38cPkUUd1vOYf+2Si8F4Q0apth7Bzpxa2ACfgKOAjU9eK6
         6x5Q==
X-Gm-Message-State: AOAM5306HQGurp7YXRtiMFfQcB6gDGAlaDIy+KA8T8SXr5toipJCVuWW
        I01QwOTFMvPaogEutP0C0fJFcw==
X-Google-Smtp-Source: ABdhPJwwKAthNUesiDBD7YBKyp9KP/QdlfGLvwvBIEuDXnh4HnLacRhZ80oPYfmXhDu3TQjDiJEjMA==
X-Received: by 2002:a63:4d5a:: with SMTP id n26mr22321711pgl.85.1591058947202;
        Mon, 01 Jun 2020 17:49:07 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:d9a3:6ef8:19c1:abf4? ([2601:646:c200:1ef2:d9a3:6ef8:19c1:abf4])
        by smtp.gmail.com with ESMTPSA id i26sm536576pfo.0.2020.06.01.17.49.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 17:49:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [GRUB PATCH RFC 00/18] i386: Intel TXT secure launcher
Date:   Mon, 1 Jun 2020 17:49:03 -0700
Message-Id: <C6007C2B-AEFF-4A48-B791-323CDC04266D@amacapital.net>
References: <f954e9ef-295a-a8ce-0ff8-a88ad81b01a3@apertussolutions.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Lukasz Hawrylko <lukasz.hawrylko@linux.intel.com>,
        grub-devel@gnu.org, LKML <linux-kernel@vger.kernel.org>,
        trenchboot-devel@googlegroups.com, X86 ML <x86@kernel.org>,
        alexander.burmashev@oracle.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        eric.snowberg@oracle.com, javierm@redhat.com,
        kanth.ghatraju@oracle.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        krystian.hebel@3mdeb.com, michal.zygowski@3mdeb.com,
        Matthew Garrett <mjg59@google.com>, phcoder@gmail.com,
        piotr.krol@3mdeb.com, Peter Jones <pjones@redhat.com>,
        Ross Philipson <ross.philipson@oracle.com>
In-Reply-To: <f954e9ef-295a-a8ce-0ff8-a88ad81b01a3@apertussolutions.com>
To:     "Daniel P. Smith" <dpsmith@apertussolutions.com>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 1, 2020, at 5:14 PM, Daniel P. Smith <dpsmith@apertussolutions.com>=
 wrote:
>=20
> =EF=BB=BFOn 6/1/20 3:39 PM, Andy Lutomirski wrote:
>>>> .
>=20
> In other words, the log for the relaunch to attest what is currently
> running is really no less useful than using the first launch log to
> attest to the what was running in the first launch.
>=20

Maybe it would help if you give some examples of what=E2=80=99s actually in t=
his log and why anyone, Linux or otherwise, cares for any purpose other than=
 debugging.  We=E2=80=99re talking about a log written by something like GRU=
B, right?  If so, I=E2=80=99m imagining things like:

GRUB: loading such-and-such module
GRUB: loading the other module
GRUB: loading Linux at /boot/vmlinuz-whatever
GRUB: about to do the DRTM launch. Bye-bye.

This is surely useful for debugging.  But, if I understand your security mod=
el correctly, it=E2=80=99s untrustworthy in the sense that this all comes fr=
om before the DRTM launch and it could have been tampered with by SMM code o=
r even just a malicious USB stick.  Or even a malicious compromised kernel o=
n the same machine. So you could hash this log into a PCR, but I don=E2=80=99=
t see what you=E2=80=99ve accomplished by doing so.

Or have I misunderstood what this log is?  Perhaps you=E2=80=99re talking ab=
out something else entirely.=
