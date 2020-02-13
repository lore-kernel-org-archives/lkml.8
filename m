Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91886C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 07:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62EDF2168B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 07:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v/6iFBYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbgBMHKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 02:10:19 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33234 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgBMHKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 02:10:19 -0500
Received: by mail-lj1-f195.google.com with SMTP id y6so5347648lji.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 23:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vg2ne5AyyglOAv8FBMMwHyfnVt31BO4UzavNdGGQICU=;
        b=v/6iFBYYAvUyH1ig7uVxg5hp1J8W8pqTDvVe0oceLhdcpHrvCci4+tF2xXQNtxzQPu
         NKnZfw4MmkSWjVBNlp37Az1Fd4k9TFuYRV7SWLWH2ToujZ9cpggJ2KTajdvy+bzqJ48u
         Amm262fwmwPMBW9u/oNOafTF4C3pXNHBnUAnMohr9hjAefmdH/GbH5ceZCSvT6lWJlxb
         VcufdzCYyhzDOx9Qc2EMeKSYxnTz8XK0IjrM6+4eSYLVdJR0lhAALzQ+4VIlbb6G16d/
         INxdJ1lb3L/AZVPz49LRoyCYB6KYpEau3aOcTip0b/Dk4M6kU7SKMGO2Bmt7UkBrmAaa
         6a9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vg2ne5AyyglOAv8FBMMwHyfnVt31BO4UzavNdGGQICU=;
        b=exIl6GMJbXwqlv6jVk7FLd9QWO4Kj3z+Ne08vHykBS6FnLCsfx7nj8TMWzYHWOT19M
         8/WUgLmNwhSJJHGi6Tj0TuQd/UQ+kZOMItGZRON1rhA2ajVXqCs3MHiTSnYsDwKZkWMb
         5XA6XvA54qQ1/Qe/GGmrW6idmlbVWO5ZW+g3HugQcdeXxnO5RErx3mzR0hArkTBmLBky
         a6sf+Tx3Busm50kNzc4ZOBulnxzOHN1Zt9quNYve1Owk9z/19K/Diq8g400kbLnT+eq/
         1j6MEGUMJKRSHYt8yoFGov6wN6m4cu1ZAjI6oUY+qvkTCEE/tmKLGiivexNYeQNvJm2a
         7nqQ==
X-Gm-Message-State: APjAAAXVifjhhN3Ms1Bsz9XBlX/IPt25ktRGbaK8FSaAoOay72obO7Fp
        1TINgfhCM4qJXSiqt+d+20v7s7mgAi0ewxiZ+eciDhOBTyQ=
X-Google-Smtp-Source: APXvYqzaqiU/b6IGWITzU+eEe7MG3UAMGPlHrN3BYM1ZLAe965Y8HgMBCww+Yvh2kbxnhfBUSc8FAGZm3qKahOTJp04=
X-Received: by 2002:a2e:7005:: with SMTP id l5mr9592622ljc.230.1581577817025;
 Wed, 12 Feb 2020 23:10:17 -0800 (PST)
MIME-Version: 1.0
References: <1654227.8mz0SueHsU@kreacher>
In-Reply-To: <1654227.8mz0SueHsU@kreacher>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 13 Feb 2020 12:40:05 +0530
Message-ID: <CAP245DXY2MsV6rf95QdATTXXZWoYYLFBO3QxQgkg=44Fw0cLNA@mail.gmail.com>
Subject: Re: [PATCH 00/28] PM: QoS: Get rid of unuseful code and rework CPU
 latency QoS interface
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 5:09 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi All,
>
> This series of patches is based on the observation that after commit
> c3082a674f46 ("PM: QoS: Get rid of unused flags") the only global PM QoS class
> in use is PM_QOS_CPU_DMA_LATENCY, but there is still a significant amount of
> code dedicated to the handling of global PM QoS classes in general.  That code
> takes up space and adds overhead in vain, so it is better to get rid of it.
>
> Moreover, with that unuseful code removed, the interface for adding QoS
> requests for CPU latency becomes inelegant and confusing, so it is better to
> clean it up.
>
> Patches [01/28-12/28] do the first part described above, which also includes
> some assorted cleanups of the core PM QoS code that doesn't go away.
>
> Patches [13/28-25/28] rework the CPU latency QoS interface (in the classic
> "define stubs, migrate users, change the API proper" manner), patches
> [26-27/28] update the general comments and documentation to match the code
> after the previous changes and the last one makes the CPU latency QoS depend
> on CPU_IDLE (because cpuidle is the only user of its target value today).
>
> The majority of the patches in this series don't change the functionality of
> the code at all (at least not intentionally).
>
> Please refer to the changelogs of individual patches for details.

Hi Rafael,

Nice cleanup to the code and docs.

I've reviewed the series, and briefly tested it by setting latencies
from userspace. Can we not remove the debugfs interface? It is a quick
way to check the global cpu latency clamp on the system from userspace
without setting up tracepoints or writing a program to read
/dev/cpu_dma_latency.

Except for patch 01/28 removing the debugfs interface, please feel to add my

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Tested-by: Amit Kucheria <amit.kucheria@linaro.org>

Regards,
Amit
