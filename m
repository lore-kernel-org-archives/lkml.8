Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1DFC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CF720727
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QpVj4wGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgCIJfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 05:35:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58865 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725796AbgCIJfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 05:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583746529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ncKQAOhDQmRBrpj/IJV0kt9E++/ehNgolZ7+C/6w0OY=;
        b=QpVj4wGnjEWSrZxkIR9GwjmKMBrqYCXvehJ7JCZpwQSKlxyXxPod7XuaBhUxWFpfECcjXM
        J0ENXpHTXLoeMUbxVs3czQzUmM1gO7c03LUvaPy28CfzQhrmVH+LXrihW+kqedNCKFHHkJ
        TURn5HT07ABqAdrJw6o8fVpwDQzXE1k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-HzjmwANcOtGXIEg8aKtNIw-1; Mon, 09 Mar 2020 05:35:27 -0400
X-MC-Unique: HzjmwANcOtGXIEg8aKtNIw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94661184C809;
        Mon,  9 Mar 2020 09:35:24 +0000 (UTC)
Received: from krava (ovpn-205-132.brq.redhat.com [10.40.205.132])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C30D819C58;
        Mon,  9 Mar 2020 09:35:17 +0000 (UTC)
Date:   Mon, 9 Mar 2020 10:35:06 +0100
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
Subject: Re: [PATCH v4 0/8] powerpc/perf: Add json file metric support for
 the hv_24x7 socket/chip level events
Message-ID: <20200309093506.GB67774@krava>
References: <20200309062552.29911-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309062552.29911-1-kjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 11:55:44AM +0530, Kajol Jain wrote:
> First patch of the patchset fix inconsistent results we are getting when
> we run multiple 24x7 events.
> 
> Patchset adds json file metric support for the hv_24x7 socket/chip level
> events. "hv_24x7" pmu interface events needs system dependent parameter
> like socket/chip/core. For example, hv_24x7 chip level events needs
> specific chip-id to which the data is requested should be added as part
> of pmu events.
> 
> So to enable JSON file support to "hv_24x7" interface, patchset expose
> total number of sockets and chips per-socket details in sysfs
> files (sockets, chips) under "/sys/devices/hv_24x7/interface/".
> 
> To get sockets and number of chips per sockets, patchset adds a rtas call
> with token "PROCESSOR_MODULE_INFO" to get these details. Patchset also
> handles partition migration case to re-init these system depended
> parameters by adding proper calls in post_mobility_fixup() (mobility.c).
> 
> Patch 6 & 8 of the patchset handles perf tool plumbing needed to replace
> the "?" character in the metric expression to proper value and hv_24x7
> json metric file for different Socket/chip resources.
> 
> Patch set also enable Hz/hz prinitg for --metric-only option to print
> metric data for bus frequency.
> 
> Applied and tested all these patches cleanly on top of jiri's flex changes
> with the changes done by Kan Liang for "Support metric group constraint"
> patchset and made required changes.
> 
> Changelog:
> v3 -> v4
> - Made changes suggested by jiri.

could you please mention them next time? ;-)

> - Apply these patch on top of Kan liang changes.

Arnaldo, could you please pull the expr flex changes and Kan's
metric group constraint changes? it's both prereq of this patchset

thanks,
jirka

