Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7A7C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8839520714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgC0IsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 04:48:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:4790 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgC0IsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 04:48:01 -0400
IronPort-SDR: OnXpwTSIoicTCA8WTE40yq6c6kAu7Imqz+buhBZPypQb1g6jAnoXkfNvuDeW5W6gqBT4IKqC8v
 DVVhKSsKRRfA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 01:48:00 -0700
IronPort-SDR: i+hVpidsIamRPL6dWnx9MuIyD/acz2sgM6HC/0Pp3xauKM9JmnWBYYehrhx5ZTdNgZAahA5Dn5
 lAwtIF7YrTmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,311,1580803200"; 
   d="scan'208";a="293877053"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Mar 2020 01:47:57 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     roman.sudarikov@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        bgregg@netflix.com, ak@linux.intel.com, kan.liang@linux.intel.com
Cc:     alexander.antonov@intel.com, roman.sudarikov@linux.intel.com,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v8 3/3] perf x86: Exposing an Uncore unit to PMON for
 Intel =?utf-8?Q?Xeon=C2=AE?= server platform
In-Reply-To: <20200320073110.4761-4-roman.sudarikov@linux.intel.com>
References: <20200320073110.4761-1-roman.sudarikov@linux.intel.com> <20200320073110.4761-4-roman.sudarikov@linux.intel.com>
Date:   Fri, 27 Mar 2020 10:47:56 +0200
Message-ID: <875zeq6v5v.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

roman.sudarikov@linux.intel.com writes:

> ---
>  .../ABI/testing/sysfs-devices-mapping         |  33 +++
>  arch/x86/events/intel/uncore.h                |   9 +
>  arch/x86/events/intel/uncore_snbep.c          | 191 ++++++++++++++++++
>  3 files changed, 233 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-mapping
>
> diff --git a/Documentation/ABI/testing/sysfs-devices-mapping b/Documentation/ABI/testing/sysfs-devices-mapping
> new file mode 100644
> index 000000000000..16f4e900be7b
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-mapping

Is this a good place for something that's perf/x86/intel/uncore
specific?

> +                Which means:
> +                IIO PMU 0 on die 0 belongs to PCI RP on bus 0x00, domain 0x0000
> +                IIO PMU 0 on die 1 belongs to PCI RP on bus 0x40, domain 0x0000
> +                IIO PMU 0 on die 2 belongs to PCI RP on bus 0x80, domain 0x0000
> +                IIO PMU 0 on die 3 belongs to PCI RP on bus 0xc0, domain 0x0000
> \ No newline at end of file

Git is trying to tell you something.

> +		eas[die].attr.attr.mode = 0444;

I believe this one is also known as S_IRUGO.

Other than that, this patch is

Reviewed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Regards,
--
Alex
