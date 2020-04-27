Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE93C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 09:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6555520663
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 09:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgD0JzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 05:55:02 -0400
Received: from foss.arm.com ([217.140.110.172]:32852 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbgD0JzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 05:55:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B8101FB;
        Mon, 27 Apr 2020 02:55:01 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63DB63F68F;
        Mon, 27 Apr 2020 02:54:58 -0700 (PDT)
Date:   Mon, 27 Apr 2020 10:54:52 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jianyong Wu <Jianyong.Wu@arm.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "yangbo.lu@nxp.com" <yangbo.lu@nxp.com>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
        "maz@kernel.org" <maz@kernel.org>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Steven Price <Steven.Price@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Steve Capper <Steve.Capper@arm.com>,
        Kaly Xin <Kaly.Xin@arm.com>, Justin He <Justin.He@arm.com>,
        nd <nd@arm.com>
Subject: Re: [RFC PATCH v11 5/9] psci: Add hypercall service for ptp_kvm.
Message-ID: <20200427095452.GA1300@C02TD0UTHF1T.local>
References: <20200421032304.26300-1-jianyong.wu@arm.com>
 <20200421032304.26300-6-jianyong.wu@arm.com>
 <20200421095736.GB16306@C02TD0UTHF1T.local>
 <ab629714-c08c-2155-dd13-ad25e7f60b39@arm.com>
 <20200424103953.GD1167@C02TD0UTHF1T.local>
 <b005e2c8-ed9f-3dc6-dbfa-5e6db5183f3c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b005e2c8-ed9f-3dc6-dbfa-5e6db5183f3c@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Apr 26, 2020 at 06:02:23AM +0100, Jianyong Wu wrote:
> <html>
> <head>
> <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
> </head>
> <body>

Please fix your mail client to reply in plain text rather than HTML;
it's much more painful than necessary to review and have a conversation
when mails revert to HTML.

It would be very helpful if you could resend this mail as plaintext as
above.

Thanks,
Mark.
