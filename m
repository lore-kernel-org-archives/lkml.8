Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B3DC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1475120838
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580755950;
	bh=pARSwgYkMBJyABhyHmnGARQ80UDtRTlxYaKZnCi/W8w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=e8HzhYycaNyPX1E8SM1Li1ZW2plihyuC1ycopnjqYn9iF0As3VZbIeKoSw9rRn2fx
	 5pJM/NswL6cZzN5o7g8IBRTz11E3K3yqiEkLHb+lhI7LlJRh0J63i3Z/tHyq+OomqG
	 jKBuas9U4CIjGmohrDlA5CoahvW8eKeXN8jkEJi8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbgBCSw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:52:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:41646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728707AbgBCSw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:52:29 -0500
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B6B321775
        for <linux-kernel@vger.kernel.org>; Mon,  3 Feb 2020 18:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580755948;
        bh=pARSwgYkMBJyABhyHmnGARQ80UDtRTlxYaKZnCi/W8w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X23f4DKcw/VO8i9LnkovXZU0Hoik5aH13r4f0uUQ5cMQWZ/Ok1NJ7rTfqQI6wdaU2
         ogIHhGOYhpMO3OFRKI1LtOsgYO7ogGe+8nyy3OfdspBZbcTe+jwfDj7FlrOh5rLEud
         I9dbBmi4OyAe7O+RPOWFpTkTXNe7Aq6fjnCNBq3w=
Received: by mail-wr1-f50.google.com with SMTP id c9so19661860wrw.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 10:52:28 -0800 (PST)
X-Gm-Message-State: APjAAAVmCBIx9CGjLOsTqRY9AuZhR42SKuej+eUoLVf4hqi7Rv41SUZC
        o5BrlGO30CCL0sS3oXJeK6KU07XlGlnCIvEGXqz7DA==
X-Google-Smtp-Source: APXvYqydAzYMpo7YlxsrmraMrL4WuCg4APe95PSY1AMc0UTpplvcfcM2vuUTrptlnD2VD/DLpbyclMaFWyipZ/AYPps=
X-Received: by 2002:a5d:4cc9:: with SMTP id c9mr16813882wrt.70.1580755946612;
 Mon, 03 Feb 2020 10:52:26 -0800 (PST)
MIME-Version: 1.0
References: <20200203151608.28053-1-xiaoyao.li@intel.com> <20200203151608.28053-7-xiaoyao.li@intel.com>
In-Reply-To: <20200203151608.28053-7-xiaoyao.li@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 3 Feb 2020 10:52:15 -0800
X-Gmail-Original-Message-ID: <CALCETrVuWY4G9-h+m9XAZDscaRrtaZ-j-F_y3qHfENvMkr1g5Q@mail.gmail.com>
Message-ID: <CALCETrVuWY4G9-h+m9XAZDscaRrtaZ-j-F_y3qHfENvMkr1g5Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] x86: vmx: virtualize split lock detection
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 3, 2020 at 7:21 AM Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>
> Due to the fact that MSR_TEST_CTRL is per-core scope, i.e., the sibling
> threads in the same physical CPU core share the same MSR, only
> advertising feature split lock detection to guest when SMT is disabled
> or unsupported for simplicitly.
>
> Only when host is sld_off, can guest control the hardware value of
> MSR_TEST_CTL, i.e., KVM loads guest's value into hardware when vcpu is
> running.
>
> The vmx->disable_split_lock_detect can be set to true after unhandled
> split_lock #AC in guest only when host is sld_warn mode. It's for not
> burnning old guest, of course malicous guest can exploit it for DoS
> attack.

Is this actually worthwhile?  This only applies to the host having
sld=off or warn and the host having HT off.  I suspect that
deployments supporting migration will not want to use this, and
multi-tenant deployments won't want to use it for SLD-aware guests doe
to DoS risk.

--Andy
