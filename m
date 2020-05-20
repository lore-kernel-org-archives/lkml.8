Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE64C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2F4720823
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590010157;
	bh=tNeHg18J8KpIUbnkvwoUOTfv+q14yZF+X4qaszsqdL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zBn4NnDvJSeMSLh5P4zZ/9HhLiwUZzJHYKs3rG6NLpAioEuPcFEvQzC3ZsTs3/o+A
	 mGLWK/9B5vFG3V2F1dVuXh7ky6F2aqurGvpnxbVDaLJ/bfMorXXSQS6jjBUVgifIKt
	 W8k4NE38C0jk2721TEbAeUeDmHlH6VnyMeM2qilI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgETV3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 17:29:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgETV3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 17:29:16 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63703207F9;
        Wed, 20 May 2020 21:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590010156;
        bh=tNeHg18J8KpIUbnkvwoUOTfv+q14yZF+X4qaszsqdL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cuBGoPqfHeYx1FqXipdaSEJ1UDMiiyPZiH2iuG7zGzREsRYHjkswEcFbv78fo9BS/
         Fyc5ytsi8JMe/DclVaIrMRT4ND0qgnWV66V6mV7K1O0G/mzgvfj59V/IRK32zIdvOP
         ZI+bn1f9Q0z9WAvWecyPY697SYlsWEbzUqw7DhfU=
From:   Will Deacon <will@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Price <steven.price@arm.com>, harb@amperecomputing.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] firmware: smccc: Add basic SMCCC v1.2 + ARCH_SOC_ID support
Date:   Wed, 20 May 2020 22:29:10 +0100
Message-Id: <158999823818.135150.13263761266508812198.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200518091222.27467-1-sudeep.holla@arm.com>
References: <20200518091222.27467-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 May 2020 10:12:15 +0100, Sudeep Holla wrote:
> This patch series adds support for SMCCCv1.2 ARCH_SOC_ID.
> This doesn't add other changes added in SMCCC v1.2 yet. They will
> follow these soon along with its first user SPCI/PSA-FF.
> 
> This is tested using upstream TF-A + the patch[3] fixing the original
> implementation there.
> 
> [...]

Applied to arm64 (for-next/smccc), thanks!

[1/7] firmware: smccc: Add HAVE_ARM_SMCCC_DISCOVERY to identify SMCCC v1.1 and above
      https://git.kernel.org/arm64/c/e5bfb21d98b6
[2/7] firmware: smccc: Update link to latest SMCCC specification
      https://git.kernel.org/arm64/c/15c704ab6244
[3/7] firmware: smccc: Add the definition for SMCCCv1.2 version/error codes
      https://git.kernel.org/arm64/c/0441bfe7f00a
[4/7] firmware: smccc: Drop smccc_version enum and use ARM_SMCCC_VERSION_1_x instead
      https://git.kernel.org/arm64/c/ad5a57dfe434
[5/7] firmware: smccc: Refactor SMCCC specific bits into separate file
      https://git.kernel.org/arm64/c/f2ae97062a48
[6/7] firmware: smccc: Add function to fetch SMCCC version
      https://git.kernel.org/arm64/c/a4fb17465182
[7/7] firmware: smccc: Add ARCH_SOC_ID support
      https://git.kernel.org/arm64/c/ce6488f0ce09

Arnd -- Sudeep's reply to you about the sysfs groups seemed reasonable to me,
but please shout if you'd rather I dropped this in order to pursue an
alternative approach.

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
