Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F71C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1070E20714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BmWaLXH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgCZT5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 15:57:31 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:31220 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727446AbgCZT5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 15:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585252649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+HcwVk5VdvJ1LeKecVY6pFDWmsucvzIVlRkfrm9XQWo=;
        b=BmWaLXH+/vRVPPM6LB3TVTtZosaMA9utLxpyFd/A6iZjyIPIUUOj49OLi5sFurI9HG9R1s
        O0sbqeYtLkK+1zUV687FPdHD8DZP80y8PYIZ9TQxrxJIDBxJdmRZH1g6nyQN+br7wndZhE
        /g/+3gC8fFlWSzilH9HezckX5msoe4s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-UpZU49OxOLqsAvXMWVVkzA-1; Thu, 26 Mar 2020 15:57:27 -0400
X-MC-Unique: UpZU49OxOLqsAvXMWVVkzA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E40EC8017CC;
        Thu, 26 Mar 2020 19:57:19 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-112.rdu2.redhat.com [10.10.117.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06A669CA3;
        Thu, 26 Mar 2020 19:57:11 +0000 (UTC)
Subject: Re: [PATCH RFC] cpuset: Make cpusets get restored on hotplug
To:     Joel Fernandes <joel@joelfernandes.org>, Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Dmitry Shmidt <dimitrysh@google.com>,
        Amit Pundir <amit.pundir@linaro.org>, kernel-team@android.com,
        jsbarnes@google.com, sonnyrao@google.com, vpillai@digitalocean.com,
        peterz@infradead.org, Guenter Roeck <groeck@chromium.org>,
        Greg Kerr <kerrnel@google.com>, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>
References: <20200326191623.129285-1-joel@joelfernandes.org>
 <20200326192035.GO162390@mtj.duckdns.org>
 <20200326194448.GA133524@google.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <972a5c1b-6721-ac20-cec5-617af67e617d@redhat.com>
Date:   Thu, 26 Mar 2020 15:57:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200326194448.GA133524@google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/20 3:44 PM, Joel Fernandes wrote:
> Hi Tejun,
>
> On Thu, Mar 26, 2020 at 03:20:35PM -0400, Tejun Heo wrote:
>> On Thu, Mar 26, 2020 at 03:16:23PM -0400, Joel Fernandes (Google) wrote:
>>> This deliberately changes the behavior of the per-cpuset
>>> cpus file to not be effected by hotplug. When a cpu is offlined,
>>> it will be removed from the cpuset/cpus file. When a cpu is onlined,
>>> if the cpuset originally requested that that cpu was part of the cpuset,
>>> that cpu will be restored to the cpuset. The cpus files still
>>> have to be hierachical, but the ranges no longer have to be out of
>>> the currently online cpus, just the physically present cpus.
>> This is already the behavior on cgroup2 and I don't think we want to
>> introduce this big a behavior change to cgroup1 cpuset at this point.
> It is not really that big a change. Please go over the patch, we are not
> changing anything with how ->cpus_allowed works and interacts with the rest
> of the system and the scheduler. We have just introduced a new mask to keep
> track of which CPUs were requested without them being affected by hotplug. On
> CPU onlining, we restore the state of ->cpus_allowed as not be affected by
> hotplug.
>
> There's 3 companies that have this issue so that should tell you something.
> We don't want to carry this patch forever. Many people consider the hotplug
> behavior to be completely broken.
>
I think Tejun is concerned about a change in the default behavior of
cpuset v1.

There is a special v2 mode for cpuset that is enabled by the mount
option "cpuset_v2_mode". This causes the cpuset v1 to adopt some of the
v2 behavior. I introduced this v2 mode a while back to address, I think,
a similar concern. Could you try that to see if it is able to address
your problem? If not, you can make some code adjustment within the
framework of the v2 mode. As long as it is an opt-in, I think we are
open to further change.

Cheers,
Longman

