Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56412C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ED78207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgE2INf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:13:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:56589 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgE2INe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:13:34 -0400
IronPort-SDR: gMDQZ5YtBTAu3WUth4f9qBfiUf04kSWCFgFMa+u0zsC78leOlzzlebeWeEn9QmpdQzEVc7CoFq
 h8aC2xe/1cJw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 01:13:34 -0700
IronPort-SDR: D2OwS10W8ZRNlx/6Re2YsoM7kJBRLFponE5d5dxkGBhZBaxQ/ruwwvpzbgjrVkk988jxA2/K/b
 SWs0rrYn6mJA==
X-IronPort-AV: E=Sophos;i="5.73,447,1583222400"; 
   d="scan'208";a="443289103"
Received: from vtsikino-mobl.ger.corp.intel.com (HELO localhost) ([10.249.43.186])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 01:13:23 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>, keescook@chromium.org,
        yzaikin@google.com, nixiaoming@huawei.com, ebiederm@xmission.com,
        axboe@kernel.dk, clemens@ladisch.de, arnd@arndb.de,
        gregkh@linuxfoundation.org, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        benh@kernel.crashing.org, rdna@fb.com, viro@zeniv.linux.org.uk,
        mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        vbabka@suse.cz, sfr@canb.auug.org.au, jack@suse.cz,
        amir73il@gmail.com, rafael@kernel.org, tytso@mit.edu
Cc:     julia.lawall@lip6.fr, akpm@linux-foundation.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linuxppc-dev@lists.ozlabs.org, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 01/13] sysctl: add new register_sysctl_subdir() helper
In-Reply-To: <20200529074108.16928-2-mcgrof@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200529074108.16928-1-mcgrof@kernel.org> <20200529074108.16928-2-mcgrof@kernel.org>
Date:   Fri, 29 May 2020 11:13:21 +0300
Message-ID: <87d06n17mm.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 May 2020, Luis Chamberlain <mcgrof@kernel.org> wrote:
> Often enough all we need to do is create a subdirectory so that
> we can stuff sysctls underneath it. However, *if* that directory
> was already created early on the boot sequence we really have no
> need to use the full boiler plate code for it, we can just use
> local variables to help us guide sysctl to place the new leaf files.

I find it hard to figure out the lifetime requirements for the tables
passed in; when it's okay to use local variables and when you need
longer lifetimes. It's not documented, everyone appears to be using
static tables for this. It's far from obvious.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
