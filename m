Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20140C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA5FD2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bIi09Xdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgBJMIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:08:18 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48216 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727879AbgBJMIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:08:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581336491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eSK8ISZif/OQRXa4102Rfe/YBGClc/e/gjEdCPPB1jI=;
        b=bIi09Xdy9A7bjchehy/BebA1tB/opbNxJGb0Rm5LOyDRngRwVeJz9h4sf8q0+m/Iat4Xp3
        mHcAlfy7zWq8+gsEr6xGNBJNC8Q6VoKOXqT4WaBovPsvlXYJeKd1lmssMZOXm26NIFQ1JT
        dlfZiJv1IvpNX/ohtVlzm2q7t4J1bHc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-VV3IeyKkOKWqK7d0Wa9iyA-1; Mon, 10 Feb 2020 07:08:06 -0500
X-MC-Unique: VV3IeyKkOKWqK7d0Wa9iyA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DAC01084424;
        Mon, 10 Feb 2020 12:08:04 +0000 (UTC)
Received: from krava (unknown [10.43.17.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B1EE319C70;
        Mon, 10 Feb 2020 12:08:01 +0000 (UTC)
Date:   Mon, 10 Feb 2020 13:07:59 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, will@kernel.org, ak@linux.intel.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        james.clark@arm.com, zhangshaokun@hisilicon.com,
        robin.murphy@arm.com
Subject: Re: [PATCH RFC 5/7] perf pmu: Support matching by sysid
Message-ID: <20200210120759.GG1907700@krava>
References: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
 <1579876505-113251-6-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579876505-113251-6-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 10:35:03PM +0800, John Garry wrote:

SNIP

> +		fclose(file);
> +		pr_debug("gets failed for file %s\n", path);
> +		free(buf);
> +		return NULL;
> +	}
> +	fclose(file);
> +
> +	/* Remove any whitespace, this could be from ACPI HID */
> +	s = strlen(buf);
> +	for (i = 0; i < s; i++) {
> +		if (buf[i] == ' ') {
> +			buf[i] = 0;
> +			break;
> +		};
> +	}
> +
> +	return buf;
> +}
> +
> +static char *perf_pmu__getsysid(void)
> +{
> +	char *sysid;
> +	static bool printed;
> +
> +	sysid = getenv("PERF_SYSID");
> +	if (sysid)
> +		sysid = strdup(sysid);
> +
> +	if (!sysid)
> +		sysid = get_sysid_str();
> +	if (!sysid)
> +		return NULL;
> +
> +	if (!printed) {
> +		pr_debug("Using SYSID %s\n", sysid);
> +		printed = true;
> +	}
> +	return sysid;
> +}

this part is getting complicated and AFAIK we have no tests for it

if you could think of any tests that'd be great.. perhaps we could
load 'our' json test files and check appropriate events/aliasses
via in pmu object.. or via parse_events interface.. those test aliases
would have to be part of perf, but we have tests compiled in anyway

thanks,
jirka

