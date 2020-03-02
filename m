Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133FFC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A5A214DB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tgt7tYX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgCBPIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:08:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56555 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727077AbgCBPIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:08:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583161730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G7Hz0vVXFpbBOfFt3NDzjDOUPmMmISH4jqXPJajKvOA=;
        b=Tgt7tYX74cTz6kePoR03nUZ26KW/M4BM5oXw4YU2p0bpum0TwDQZjKCeEuvRiNly7tVUoD
        7I8x3B232d9MOg2jjsmGe/3fUz/XwO6V36B1noeGtEmyRjHEpBSbdlYdknXVY4jWikcIAZ
        hexjHZaIjaz2CaRsaIdlWb35n0E62a8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-Q0MZdmfDNFa00WUN4iiOoA-1; Mon, 02 Mar 2020 10:08:46 -0500
X-MC-Unique: Q0MZdmfDNFa00WUN4iiOoA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B199E800D4E;
        Mon,  2 Mar 2020 15:08:42 +0000 (UTC)
Received: from krava (ovpn-205-46.brq.redhat.com [10.40.205.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A9C4100194E;
        Mon,  2 Mar 2020 15:08:22 +0000 (UTC)
Date:   Mon, 2 Mar 2020 16:08:19 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com,
        maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com,
        peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com,
        jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com,
        tglx@linutronix.de
Subject: Re: [PATCH v3 6/8] perf/tools: Enhance JSON/metric infrastructure to
 handle "?"
Message-ID: <20200302150819.GA259142@krava>
References: <20200229094159.25573-1-kjain@linux.ibm.com>
 <20200229094159.25573-7-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229094159.25573-7-kjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 29, 2020 at 03:11:57PM +0530, Kajol Jain wrote:

SNIP

>  #define PVR_VER(pvr)    (((pvr) >>  16) & 0xFFFF) /* Version field */
>  #define PVR_REV(pvr)    (((pvr) >>   0) & 0xFFFF) /* Revison field */
>  
> +#define SOCKETS_INFO_FILE_PATH "/devices/hv_24x7/interface/"
> +
>  int
>  get_cpuid(char *buffer, size_t sz)
>  {
> @@ -44,3 +51,43 @@ get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
>  
>  	return bufp;
>  }
> +
> +int arch_get_runtimeparam(void)
> +{
> +	int count = 0;
> +	DIR *dir;
> +	char path[PATH_MAX];
> +	const char *sysfs = sysfs__mountpoint();
> +	char filename[] = "sockets";
> +	FILE *file;
> +	char buf[16], *num;
> +	int data;
> +
> +	if (!sysfs)
> +		goto out;
> +
> +	snprintf(path, PATH_MAX,
> +		 "%s" SOCKETS_INFO_FILE_PATH, sysfs);
> +	dir = opendir(path);
> +
> +	if (!dir)
> +		goto out;
> +
> +	strcat(path, filename);
> +	file = fopen(path, "r");
> +
> +	if (!file)
> +		goto out;
> +
> +	data = fread(buf, 1, sizeof(buf), file);
> +
> +	if (data == 0)
> +		goto out;
> +
> +	count = strtol(buf, &num, 10);
> +out:
> +	if (!count)
> +		count = 1;
> +
> +	return count;

we have sysfs__read_ull for this

jirka

