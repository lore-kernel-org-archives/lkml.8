Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9B4C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 08:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7DB206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 08:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgCLIFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 04:05:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:3476 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgCLIFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 04:05:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 01:05:20 -0700
X-IronPort-AV: E=Sophos;i="5.70,544,1574150400"; 
   d="scan'208";a="236744025"
Received: from fpirou-mobl.ger.corp.intel.com (HELO localhost) ([10.252.52.195])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 01:05:18 -0700
From:   "Patrick Ohly" <patrick.ohly@intel.com>
To:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        virtio-fs@redhat.com, miklos@szeredi.hu
Cc:     stefanha@redhat.com, dgilbert@redhat.com, mst@redhat.com
Subject: Re: [PATCH 00/20] virtiofs: Add DAX support
In-Reply-To: <20200304165845.3081-1-vgoyal@redhat.com>
Organization: Intel GmbH, Dornacher Strasse 1, D-85622 Feldkirchen/Munich
References: <20200304165845.3081-1-vgoyal@redhat.com>
Date:   Wed, 11 Mar 2020 14:38:03 +0100
Message-ID: <yrjh1rpzggg4.fsf@pohly-mobl1.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@redhat.com> writes:
> This patch series adds DAX support to virtiofs filesystem. This allows
> bypassing guest page cache and allows mapping host page cache directly
> in guest address space.
>
> When a page of file is needed, guest sends a request to map that page
> (in host page cache) in qemu address space. Inside guest this is
> a physical memory range controlled by virtiofs device. And guest
> directly maps this physical address range using DAX and hence gets
> access to file data on host.
>
> This can speed up things considerably in many situations. Also this
> can result in substantial memory savings as file data does not have
> to be copied in guest and it is directly accessed from host page
> cache.

As a potential user of this, let me make sure I understand the expected
outcome: is the goal to let virtiofs use DAX (for increased performance,
etc.) or also let applications that use virtiofs use DAX?

You are mentioning using the host's page cache, so it's probably the
former and MAP_SYNC on virtiofs will continue to be rejected, right?

-- 
Best Regards

Patrick Ohly
