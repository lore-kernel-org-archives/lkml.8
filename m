Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C13AC433FC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E610C224B1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgGNNeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:34:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:19097 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727925AbgGNNd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:33:57 -0400
IronPort-SDR: AnBqV1kc8Cj5OdFzXAvchzPCJ+5mvObDXOtPcmYQPqMeJIhoCBSWChwFzmpZwMctVXZqSCmOTB
 cqyHfw/KprBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="136349156"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="136349156"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 06:33:57 -0700
IronPort-SDR: rrZ1bSERUgKSuqiBPFOVgVjs4jYQ+9u5vAjvsiwiZ3l/LqlEK3KFRuiBNl+3x5FGScs1S5RZXE
 v4WP7wBZ5NtA==
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="459691310"
Received: from dconcanx-desk.ger.corp.intel.com ([10.252.20.124])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 06:33:52 -0700
Message-ID: <445bb8712b57edb02e776bc47a1350c43f37efff.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/5] Add initial Keem Bay SoC / Board support
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
List-Id: <soc.lore.kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        DTML <devicetree@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Paul Murphy <paul.j.murphy@intel.com>,
        Will Deacon <will@kernel.org>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Date:   Tue, 14 Jul 2020 14:33:44 +0100
In-Reply-To: <CAK8P3a3GVZftAZKEHC3TjDRL86vYOkND6TNuVq1KjssOHi5AXw@mail.gmail.com>
References: <20200708175020.194436-1-daniele.alessandrelli@linux.intel.com>
         <CAK8P3a3GVZftAZKEHC3TjDRL86vYOkND6TNuVq1KjssOHi5AXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-14 at 14:40 +0200, Arnd Bergmann wrote:
> On Wed, Jul 8, 2020 at 7:50 PM Daniele Alessandrelli
> <daniele.alessandrelli@linux.intel.com> wrote:
> > Hi,
> > 
> > This patch-set adds initial support for a new Intel Movidius SoC
> > code-named
> > Keem Bay. The SoC couples an ARM Cortex A53 CPU with an Intel
> > Movidius VPU.
> > 
> > This initial patch-set enables only the minimal set of components
> > required
> > to make the Keem Bay EVM board boot into initramfs.
> > 
> > Changes from v1 to v2:
> > * Moved keembay-scmi-mailbox driver to a separate patchset
> > * Removed Keem Bay SCMI mailbox and SCMI node from Keem Bay SoC
> > device tree
> 
> This all looks basically ok, but I noticed that the DT bindings ands
> DTS files all have a
> "GPL-2.0-only" tag. Usually we make those dual-licensed in order to
> make it easier
> to distribute them with a non-GPL bootloader and synchronize them
> between
> projects.
> 
> Do you know if the GPL-2.0-only part was picked intentionally, or if
> it can
> be changed to dual-licensed?

Thanks for reviewing the patchset. I'll change those files to dual-
licensed and re-submit.

