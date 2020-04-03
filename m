Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B31BC2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E28206E9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fii5g44E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404124AbgDCQKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:10:35 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26903 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404030AbgDCQKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585930232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eP7ClUiEc6wxzyPpIfOZtYlk/BTjbvCUBAhRW9+z9Mo=;
        b=fii5g44EnUT/l6SMjM9Qr9RXEaSKzEyr9pY9ywBsSVLzvUzs1dkwnEUTngDYTDWxhHIet2
        NngPE4cuitvYhDVuESIiEqexc1Azcw9xfKqFut26ROMVIFeVFpDlkga6qWktIZCWQ89gDJ
        NkckMsT1AEMh3G+5PFyO1V9bgTa6djU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-A_PBiK6jO2WX0WyHi9BemA-1; Fri, 03 Apr 2020 12:10:28 -0400
X-MC-Unique: A_PBiK6jO2WX0WyHi9BemA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81FF313FB;
        Fri,  3 Apr 2020 16:10:26 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-94.rdu2.redhat.com [10.10.118.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1BC3110027A8;
        Fri,  3 Apr 2020 16:10:24 +0000 (UTC)
Subject: Re: [PATCH v2] docs: cgroup-v1: Document the cpuset_v2_mode mount
 option
To:     Tejun Heo <tj@kernel.org>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Sonny Rao <sonnyrao@google.com>
References: <20200330140615.25549-1-longman@redhat.com>
 <20200403154343.GE162390@mtj.duckdns.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <1434c1e9-bc2d-f21e-a9a8-060c1812fc8e@redhat.com>
Date:   Fri, 3 Apr 2020 12:10:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200403154343.GE162390@mtj.duckdns.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/20 11:43 AM, Tejun Heo wrote:
> On Mon, Mar 30, 2020 at 10:06:15AM -0400, Waiman Long wrote:
>> The cpuset in cgroup v1 accepts a special "cpuset_v2_mode" mount
>> option that make cpuset.cpus and cpuset.mems behave more like those in
>> cgroup v2.  Document it to make other people more aware of this feature
>> that can be useful in some circumstances.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Applied to cgroup/for-5.7.
>
> Thanks.
>
Thanks,
Longman

