Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED49AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0269206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbgGMNAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 09:00:37 -0400
Received: from foss.arm.com ([217.140.110.172]:33062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgGMNAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:00:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C597630E;
        Mon, 13 Jul 2020 06:00:36 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EEA7A3F887;
        Mon, 13 Jul 2020 06:00:35 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, arnd@arndb.de
Subject: Re: [PATCH 1/3] firmware: arm_scmi: Remove zero-length array in SCMI Notifications
Date:   Mon, 13 Jul 2020 14:00:26 +0100
Message-Id: <159464497507.50199.2586393138950387891.b4-ty@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710133919.39792-1-cristian.marussi@arm.com>
References: <20200710133919.39792-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jul 2020 14:39:17 +0100, Cristian Marussi wrote:
> Substitute zero-length array defined in scmi_base_error_report with
> a flexible length array definition.


Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/3] firmware: arm_scmi: Remove zero-length array in SCMI notifications
      https://git.kernel.org/sudeep.holla/c/02c003cc18
[2/3] firmware: arm_scmi: Remove unneeded __packed attribute
      https://git.kernel.org/sudeep.holla/c/33ee97f823
[3/3] (korg_sudeep/for-next/scmi) firmware: arm_scmi: Remove fixed size fields from reports/scmi_event_header
      https://git.kernel.org/sudeep.holla/c/72a5eb9d9c

--
Regards,
Sudeep

