Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9756C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A272B20757
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FWcITW8h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgCRPAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 11:00:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:59088 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726726AbgCRPAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584543621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vM5m3AgHzQ8TLHWUI0zWYeLWIk49n7q4tlPXYDa1gEQ=;
        b=FWcITW8h9pdTlAORXzYB3p0IJSisHmFknF2lLYFTUKgXIEtdJfdUWnyj8ghbIj2+AG4UBc
        AD0fZW8/YSUZBiUnpUw1X0pMWeIMc5aEg0/7XI81AWpaQwCz1qn0kqFJ++Uc6DfJAdvl76
        e2UYJ3id9J1YOilW7WfU/vFsRZVuS1k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-inQ68xkTNmaFnsw9eEUiKw-1; Wed, 18 Mar 2020 11:00:19 -0400
X-MC-Unique: inQ68xkTNmaFnsw9eEUiKw-1
Received: by mail-wm1-f71.google.com with SMTP id r23so1201270wmn.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 08:00:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=vM5m3AgHzQ8TLHWUI0zWYeLWIk49n7q4tlPXYDa1gEQ=;
        b=lT8xCW2NJLTqEUBccJ/anoPJKUYeTl5G1QvKWldwiUnHViLC6zwCNbL6L0rRDngntZ
         NEVm11jyxAlsIoE4uDMMvl0ShcsCCaf4/P5S6r6M4o8C52L1AYczbj8esSy+gcsJqvSe
         XzTS5pVr2R3oU7eS+uezqQcumoUvdCmhSPox2EwN9yxeRvLe96pVud8c4WkR4nMkBfwF
         Mqm5DP/QCaoJRy0FJdqcYdfI2dv0yy3GcWJixryA4SsOBPyOYdCZvbSsFwt/amsMgSDz
         F5bXuOdZYiurttb9zIfB6+4ekIR8kVuUMGyuxQUpKEtuYmAZEUZ97RB5MEsws0+PiIWc
         Ay8Q==
X-Gm-Message-State: ANhLgQ2p9vD2eXz5RW2hf0ljDhgi+0rmJAKbKsJu085fhs71t6k8SBfe
        a2r8kCIPgyWXiEA0mmWWidpksUa5e1oN/eii0RkMGX2Ow87/HDVdVkJnVDAC5bTq+2lcLzEZAmn
        nCK2Xv8zr5A+pkMrY49G269M7
X-Received: by 2002:a5d:474c:: with SMTP id o12mr6171258wrs.156.1584543618597;
        Wed, 18 Mar 2020 08:00:18 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv+zT1QJmX75ZvxUY39VsKhPCv6bUGTeJatv+Ce8GRjcg/v0Lus2RekaAdHVMZwveqCGhi86Q==
X-Received: by 2002:a5d:474c:: with SMTP id o12mr6171235wrs.156.1584543618411;
        Wed, 18 Mar 2020 08:00:18 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id x13sm4631033wmj.5.2020.03.18.08.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 08:00:17 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-hyperv@vger.kernel.org, Yumei Huang <yuhuang@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Eduardo Habkost <ehabkost@redhat.com>,
        Milan Zamazal <mzamazal@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Paul Mackerras <paulus@samba.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v2 0/8] mm/memory_hotplug: allow to specify a default online_type
In-Reply-To: <20200318144119.GD30899@MiWiFi-R3L-srv>
References: <20200317104942.11178-1-david@redhat.com> <20200318130517.GC30899@MiWiFi-R3L-srv> <87d0993gto.fsf@vitty.brq.redhat.com> <20200318144119.GD30899@MiWiFi-R3L-srv>
Date:   Wed, 18 Mar 2020 16:00:15 +0100
Message-ID: <874kul3dz4.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baoquan He <bhe@redhat.com> writes:

> Is there a reason hyperV need boot with small memory, then enlarge it
> with huge memory? Since it's a real case in hyperV, I guess there must
> be reason, I am just curious.
>

It doesn't really *need* to but this can be utilized in e.g. 'hot
standby' schemes I believe. Also, it may be enough if the administrator
is just trying to e.g. double the size of RAM but the VM is already
under memory pressure. I wouldn't say that these cases are common but
afair bugs like 'I tried adding more memory to my VM and it just OOMed'
were reported in the past.

-- 
Vitaly

