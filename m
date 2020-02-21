Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2691EC35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F044A20656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yg8FCiVy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgBUOsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:48:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38747 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727315AbgBUOsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:48:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582296497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7m+U2u3LaQTIpjCfLQvw6WylVE2W3s9vxKa/KZB4vnU=;
        b=Yg8FCiVyGERM2Do56hv7U6+Gq2brqYK1HrM4eeRnzxab59YJ8tn4rwPrvIblB+xGNIpwOm
        mXGGg5VN55TEx7vQvP5gGilGaTM4sui9Pe9NPy5BXacJdmP2yPfRlYPdJQWF+JZohTiDOg
        ukj0+J//ScHYvS8WSJcAAzP9YaI24gM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-CtmXQnTaMT26BGY8f3Zd1w-1; Fri, 21 Feb 2020 09:48:12 -0500
X-MC-Unique: CtmXQnTaMT26BGY8f3Zd1w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1ADC78017DF;
        Fri, 21 Feb 2020 14:48:10 +0000 (UTC)
Received: from krava (unknown [10.43.17.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7728C8B745;
        Fri, 21 Feb 2020 14:48:05 +0000 (UTC)
Date:   Fri, 21 Feb 2020 15:48:03 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        namhyung@kernel.org, ravi.bangoria@linux.ibm.com,
        yao.jin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH 4/5] perf metricgroup: Support metric constraint
Message-ID: <20200221144803.GB657629@krava>
References: <1582139320-75181-1-git-send-email-kan.liang@linux.intel.com>
 <1582139320-75181-5-git-send-email-kan.liang@linux.intel.com>
 <20200220113530.GA565976@krava>
 <fea147db-2af3-e9ec-fb23-f9db8cf1c77a@linux.intel.com>
 <20200221130903.GC652992@krava>
 <300208e8-2526-8f17-a28a-d4e244baaf90@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <300208e8-2526-8f17-a28a-d4e244baaf90@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 09:30:15AM -0500, Liang, Kan wrote:
> 
> 
> On 2/21/2020 8:09 AM, Jiri Olsa wrote:
> > On Thu, Feb 20, 2020 at 11:14:09AM -0500, Liang, Kan wrote:
> > > 
> > > 
> > > On 2/20/2020 6:35 AM, Jiri Olsa wrote:
> > > > On Wed, Feb 19, 2020 at 11:08:39AM -0800, kan.liang@linux.intel.com wrote:
> > > > 
> > > > SNIP
> > > > 
> > > > > +static bool violate_nmi_constraint;
> > > > > +
> > > > > +static bool metricgroup__has_constraint(struct pmu_event *pe)
> > > > > +{
> > > > > +	if (!pe->metric_constraint)
> > > > > +		return false;
> > > > > +
> > > > > +	if (!strcmp(pe->metric_constraint, "NO_NMI_WATCHDOG") &&
> > > > > +	    sysctl__nmi_watchdog_enabled()) {
> > > > > +		pr_warning("Splitting metric group %s into standalone metrics.\n",
> > > > > +			   pe->metric_name);
> > > > > +		violate_nmi_constraint = true;
> > > > 
> > > > no static flags plz.. can't you just print that rest of the warning in here?
> > > > 
> > > 
> > > Because we only want to print the NMI watchdog warning once.
> > > If there are more than one metric groups with constraint, the warning may be
> > > printed several times. For example,
> > >    $ perf stat -M Page_Walks_Utilization,Page_Walks_Utilization
> > >    Splitting metric group Page_Walks_Utilization into standalone metrics.
> > >    Try disabling the NMI watchdog to comply NO_NMI_WATCHDOG metric
> > > constraint:
> > >        echo 0 > /proc/sys/kernel/nmi_watchdog
> > >        perf stat ...
> > >        echo 1 > /proc/sys/kernel/nmi_watchdog
> > >    Splitting metric group Page_Walks_Utilization into standalone metrics.
> > >    Try disabling the NMI watchdog to comply NO_NMI_WATCHDOG metric
> > > constraint:
> > >        echo 0 > /proc/sys/kernel/nmi_watchdog
> > >        perf stat ...
> > >        echo 1 > /proc/sys/kernel/nmi_watchdog
> > > Is it OK?
> > > 
> > > If it's OK, I think we can remove the flag.
> > 
> > we use the 'print once' static flags in functions,
> > so plz keep it inside like WARN_ONCE, or use it directly
> > 
> 
> If using WARN_ONCE, the warning is always printed for the first violation.
> For example,
> 
>  #perf stat -M Page_Walks_Utilization,Page_Walks_Utilization
>  Splitting metric group Page_Walks_Utilization into standalone metrics.
>  Try disabling the NMI watchdog to comply NO_NMI_WATCHDOG metric constraint:
>      echo 0 > /proc/sys/kernel/nmi_watchdog
>      perf stat ...
>      echo 1 > /proc/sys/kernel/nmi_watchdog
>  Splitting metric group Page_Walks_Utilization into standalone metrics.
> 
> 
> The output of current patch is as below.
>  #perf stat -M Page_Walks_Utilization,Page_Walks_Utilization
>  Splitting metric group Page_Walks_Utilization into standalone metrics.
>  Splitting metric group Page_Walks_Utilization into standalone metrics.
>  Try disabling the NMI watchdog to comply NO_NMI_WATCHDOG metric constraint:
>      echo 0 > /proc/sys/kernel/nmi_watchdog
>      perf stat ...
>      echo 1 > /proc/sys/kernel/nmi_watchdog
> 
> 
> Personally, I think the output of current patch looks better.
> But there is nothing wrong with the output of WARN_ONCE.
> 
> Should I use WARN_ONCE in next V2?

I just wanted you to keep that static flag inside the function,
so we don't have another static variable used across the code

if the WARN_ONCE does not fit, just use your own flag inside
the function

jirka

