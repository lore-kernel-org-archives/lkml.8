Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED5EC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 943D420714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZ77FHaU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgBKNr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:47:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29940 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727887AbgBKNr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:47:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581428845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vZZXarGtig3tAtPPECD18uPxu8CsjJJba6XrWOt6Ku8=;
        b=QZ77FHaU1qq9hKyJTf6kaJUnIW1o9hW/CCKK6L2FnUTJ2X5f6McuAMjxAnEu4ACgJrOaB7
        kQux6/jV7G6qkk4Bc1cwEXIZDO8QwjNUDmojqDgwCqZ5Oe1q4GsT4zfd54CKhizo0JTmEP
        mFTsMOaDF+P8xyWy7bG5SFRCpKRsq+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-mOtB-_kLPb29C5VUCfBX7w-1; Tue, 11 Feb 2020 08:47:13 -0500
X-MC-Unique: mOtB-_kLPb29C5VUCfBX7w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C6231800D42;
        Tue, 11 Feb 2020 13:47:11 +0000 (UTC)
Received: from krava (ovpn-204-250.brq.redhat.com [10.40.204.250])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D54F5DA7B;
        Tue, 11 Feb 2020 13:47:06 +0000 (UTC)
Date:   Tue, 11 Feb 2020 14:47:04 +0100
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
Message-ID: <20200211134704.GB93194@krava>
References: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
 <1579876505-113251-6-git-send-email-john.garry@huawei.com>
 <20200210120759.GG1907700@krava>
 <63799909-067b-e5f4-dcf1-9ba1ec145348@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63799909-067b-e5f4-dcf1-9ba1ec145348@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 04:22:56PM +0000, John Garry wrote:
> Hi jirka,
> 
> > 
> > > +		fclose(file);
> > > +		pr_debug("gets failed for file %s\n", path);
> > > +		free(buf);
> > > +		return NULL;
> > > +	}
> > > +	fclose(file);
> > > +
> > > +	/* Remove any whitespace, this could be from ACPI HID */
> > > +	s = strlen(buf);
> > > +	for (i = 0; i < s; i++) {
> > > +		if (buf[i] == ' ') {
> > > +			buf[i] = 0;
> > > +			break;
> > > +		};
> > > +	}
> > > +
> > > +	return buf;
> > > +}
> > > +
> 
> I have another series to add kernel support for a system identifier sysfs
> entry, which I sent after this series:
> 
> https://lore.kernel.org/linux-acpi/1580210059-199540-1-git-send-email-john.garry@huawei.com/
> 
> It is different to what I am relying on here - it uses a kernel soc driver
> for firmware ACPI PPTT identifier. Progress is somewhat blocked at the
> moment however and I may have to use a different method:
> 
> https://lore.kernel.org/linux-acpi/20200128123415.GB36168@bogus/

I'll try to check ;-)

> 
> > > +static char *perf_pmu__getsysid(void)
> > > +{
> > > +	char *sysid;
> > > +	static bool printed;
> > > +
> > > +	sysid = getenv("PERF_SYSID");
> > > +	if (sysid)
> > > +		sysid = strdup(sysid);
> > > +
> > > +	if (!sysid)
> > > +		sysid = get_sysid_str();
> > > +	if (!sysid)
> > > +		return NULL;
> > > +
> > > +	if (!printed) {
> > > +		pr_debug("Using SYSID %s\n", sysid);
> > > +		printed = true;
> > > +	}
> > > +	return sysid;
> > > +}
> > 
> > this part is getting complicated and AFAIK we have no tests for it
> > 
> > if you could think of any tests that'd be great.. Perhaps we could
> > load 'our' json test files and check appropriate events/aliasses
> > via in pmu object.. or via parse_events interface.. those test aliases
> > would have to be part of perf, but we have tests compiled in anyway
> 
> Sorry, I don't fully follow.
> 
> Are you suggesting that we could load the specific JSONs tables for a system
> from the host filesystem?

I wish to see some test for all this.. I can only think about having
'test' json files compiled with perf and 'perf test' that looks them
up and checks that all is in the proper place

jirka

