Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6168C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7456021741
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FEpwocI4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="Vw7oQVfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgBGSWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 13:22:19 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55140 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgBGSWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 13:22:19 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5208054BE5;
        Fri,  7 Feb 2020 13:22:14 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=9WMxIP/6iHc0Gn3chTdRzQ3KxHU=; b=FEpwoc
        I41pCIqAxDwVR86rLcehMVcqkyEXcM10jHEuTCdObNSYtEsbaQqITX1o40c63rti
        vOznHwvsVf3ljZ05dhXNhiZHn/X5YgTvkQT8LWGWXnmjHqOtQP88cbBYOu/os2o3
        65KqrgZzMNl6AH7bWvpp5KljMyR0bd7IcKRv0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4911754BE4;
        Fri,  7 Feb 2020 13:22:14 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=bjuIsYXrSyPas58NLMHos31uoWzRJgrzhJvJZEoIqKc=; b=Vw7oQVfScGIdW3D2Et32jFVqLSKE8uiAmdnnSax66r/GiJuQxfKmAGC7VTHZ3wQfGDw7vKta4bJThg3rMHHPcExE0jRL1lyGqODtmpDSnHAQCHLI24nCpe2VZa+5Lyf1UwlL4QO5/H6oK8T+2QJBNH9z1P9s7DOSq/ql7uBKuSY=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BCBF854BE3;
        Fri,  7 Feb 2020 13:22:13 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id E72BD2DA095A;
        Fri,  7 Feb 2020 13:22:12 -0500 (EST)
Date:   Fri, 7 Feb 2020 13:22:12 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Quentin Perret <qperret@google.com>
cc:     masahiroy@kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, maennich@google.com,
        kernel-team@android.com, jeyu@kernel.org, hch@infradead.org
Subject: Re: [PATCH v3 1/3] kbuild: allow symbol whitelisting with
 TRIM_UNUSED_KSYMS
In-Reply-To: <20200207180755.100561-2-qperret@google.com>
Message-ID: <nycvar.YSQ.7.76.2002071319200.1559@knanqh.ubzr>
References: <20200207180755.100561-1-qperret@google.com> <20200207180755.100561-2-qperret@google.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: C36052A0-49D6-11EA-A75E-C28CBED8090B-78420484!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Feb 2020, Quentin Perret wrote:

> @Nicolas: I left your Reviewed-by behind as the code has changed a bit
> but let me know what you think
> ---
>  init/Kconfig                | 13 +++++++++++++
>  scripts/adjust_autoksyms.sh |  5 +++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index a34064a031a5..79fd976ce031 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -2180,6 +2180,19 @@ config TRIM_UNUSED_KSYMS
>  
>  	  If unsure, or if you need to build out-of-tree modules, say N.
>  
> +config UNUSED_KSYMS_WHITELIST
> +	string "Whitelist of symbols to keep in ksymtab"
> +	depends on TRIM_UNUSED_KSYMS
> +	help
> +	  By default, all unused exported symbols will be un-exported from the
> +	  build when TRIM_UNUSED_KSYMS is selected.
> +
> +	  UNUSED_KSYMS_WHITELIST allows to whitelist symbols that must be kept
> +	  exported at all times, even in absence of in-tree users. The value to
> +	  set here is the path to a text file containing the list of symbols,
> +	  one per line. The path can be absolute, or relative to the kernel
> +	  source tree.
> +
>  endif # MODULES
>  
>  config MODULES_TREE_LOOKUP
> diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
> index a904bf1f5e67..58335eee4b38 100755
> --- a/scripts/adjust_autoksyms.sh
> +++ b/scripts/adjust_autoksyms.sh
> @@ -38,6 +38,10 @@ esac
>  # We need access to CONFIG_ symbols
>  . include/config/auto.conf
>  
> +# The symbol whitelist, relative to the source tree
> +eval ksym_wl="${CONFIG_UNUSED_KSYMS_WHITELIST:-/dev/null}"
> +[[ "$ksym_wl" =~ ^/ ]] || ksym_wl="$abs_srctree/$ksym_wl"

This "[[ ]]" is a bashism. I think there was an effort not to depend on 
bash for the build system. So either this needs to be changed to basic 
bourne shell, or the interpretor has to be /bin/bash not /bin/sh.


Nicolas
