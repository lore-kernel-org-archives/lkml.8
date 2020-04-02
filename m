Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D50C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F962074D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="nkiZEh/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388925AbgDBOxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:53:50 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:35144 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388912AbgDBOxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:53:50 -0400
Received: by mail-pj1-f48.google.com with SMTP id g9so1612377pjp.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 07:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:date:subject:message-id
         :cc:to;
        bh=QqBv4NN4voDZzUpUtzi0uN0Vde0acKqaGt+OV750X8I=;
        b=nkiZEh/0EdmbRpv2Hjn0FD1ORWlc6t8QyOaPwCuh6oy5eKHmIMqOzWvVtA+HTtsIFq
         ZDSePgDO5/pVllcGQF6FfmU/OewGy4ibGE23JCmxrwrG/k7x9j2nWltTOiIdCj8bGXFa
         3XELRgZ3JCpw8sYtOhI+BrJjYXMxylTuBwWTt1Zj5Yv13Ud6FDl2+5gTUpXvtnO8+N6Q
         4+JQ1eoNlZHf6uj7j3pW4BBmN3451I6ejAzbY2b8hHwlf3JbHcO+OJwV7CNEpm4vLqwd
         elL9GHdLvQi+kG9Nm17etOG0b7HO6oM0STKlaCEkBGKY7YGqy9QewAcdqhw7dneyyidk
         hsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:cc:to;
        bh=QqBv4NN4voDZzUpUtzi0uN0Vde0acKqaGt+OV750X8I=;
        b=kgLEglSPgxvp6rvXRXtJesmjKqY+9BsCdV/WOGi8iae/iRpvDx1g0PPChNxhGqK8Bl
         epbow7kErdnwlCDM3mW1/1ItefFHZElxnEGeRpouozGQS4t4H2KqD1FU/wSzRbOZEamc
         RpFAFATTLdtpXTMY9sns0iskFmrhGwhqrXlyK1TazGPYA+MQ/l7CuZ41hUX18cnqMZgw
         u3Ffi6oxHt/8gVhvaJSvlHj7PoAYNR8UmAEBly+6ihT+uECnuRVHEVjBekUeS8QXZb6x
         7r8owNoCwJ0ESNAkBNBNxa4Wfkasi/eTquYHpJwEdQ1359lFo8bO9404ZfvdeWoICqoh
         WyUg==
X-Gm-Message-State: AGi0PubnywR+2LIofrFnjLF3Cdf8+q3TQm3PU6bfLv6k5Nzx6EZcvsCY
        apKFI0WT2TpXokARAMOD8DdXLw==
X-Google-Smtp-Source: APiQypJ5LA6fynqsT+n0LZ5jOhFSeWgWjYx28yIIn7AkkJvdexgwk4ifuj6HHogZFJaFhWP9JNVYPA==
X-Received: by 2002:a17:90a:a602:: with SMTP id c2mr4148870pjq.135.1585839228902;
        Thu, 02 Apr 2020 07:53:48 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:20df:efa9:6ad3:9221? ([2601:646:c200:1ef2:20df:efa9:6ad3:9221])
        by smtp.gmail.com with ESMTPSA id d188sm3840497pfa.7.2020.04.02.07.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 07:53:47 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Date:   Thu, 2 Apr 2020 07:53:45 -0700
Subject: Re: [patch 1/2] x86,module: Detect VMX modules and disable Split-Lock-Detect
Message-Id: <A3312A4A-96A6-46A3-8C37-5AF5312FDF29@amacapital.net>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Apr 2, 2020, at 6:01 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20

This seems like much more of a fixup than we would usually do for out-of-tre=
e modules.  How about just refusing to load the offending module?=
