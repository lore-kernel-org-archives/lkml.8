Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E56C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 09:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3A22072A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 09:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbgAJJnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 04:43:02 -0500
Received: from foss.arm.com ([217.140.110.172]:41394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727269AbgAJJnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 04:43:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43CDC1063;
        Fri, 10 Jan 2020 01:43:01 -0800 (PST)
Received: from [192.168.1.18] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 752DB3F6C4;
        Fri, 10 Jan 2020 01:42:54 -0800 (PST)
Subject: Re: [PATCHv8 02/34] lib/vdso: make do_hres and do_coarse as
 __always_inline
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
References: <20191112012724.250792-1-dima@arista.com>
 <20191112012724.250792-3-dima@arista.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <ed2e65ae-75b0-ed79-0a95-90be6b82e6be@arm.com>
Date:   Fri, 10 Jan 2020 09:45:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191112012724.250792-3-dima@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/19 1:26 AM, Dmitry Safonov wrote:
> +» » vd·=·&vd[CS_HRES_COARSE];
> +out_hres:
> +» » return·do_hres(vd,·clock,·ts);
> » }·else·if·(msk·&·VDSO_COARSE)·{
> » » do_coarse(&vd[CS_HRES_COARSE],·clock,·ts);
> » » return·0;
> » }·else·if·(msk·&·VDSO_RAW)·{
> -» » return·do_hres(&vd[CS_RAW],·clock,·ts);
> +» » vd·=·&vd[CS_RAW];
> +» » /*·goto·allows·to·avoid·extra·inlining·of·do_hres.·*/
> +» » goto·out_hres;

What is the performance impact of "goto out_hres"?

-- 
Regards,
Vincenzo
