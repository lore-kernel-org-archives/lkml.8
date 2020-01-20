Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73EBC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 19:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC017217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 19:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgATTDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 14:03:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34141 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgATTDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 14:03:01 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1itcK7-0006Ja-EC; Mon, 20 Jan 2020 20:02:55 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id BCE58105BE6; Mon, 20 Jan 2020 20:02:54 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Anthony Steinhauser <asteinhauser@google.com>,
        linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, bp@alien8.de,
        Anthony Steinhauser <asteinhauser@google.com>
Subject: Re: [PATCH] Return ENXIO instead of EPERM when speculation control is unimplemented
In-Reply-To: <20191229164830.62144-1-asteinhauser@google.com>
References: <20191229164830.62144-1-asteinhauser@google.com>
Date:   Mon, 20 Jan 2020 20:02:54 +0100
Message-ID: <87o8uy2boh.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony,

Anthony Steinhauser <asteinhauser@google.com> writes:
>  		return "";
>  
>  	switch (spectre_v2_user) {
> -	case SPECTRE_V2_USER_NONE:
> +	case SPECTRE_V2_USER_UNAVAILABLE:
> +		return ", STIBP: unavailable";

Shouldn't this for correctness differentiate between the case where the
STIBP mitigation feature is not available and the case where STIBP is
not used because SMT is not possible?

Thanks,

        tglx
