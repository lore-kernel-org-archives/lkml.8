Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488E8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 124282088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593670777;
	bh=MxgNV0Luz6uzOBEruxYvte7N0aBjm3Mo8LXs6BS4BXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Uv4MQtFlCYZMVGfevUPUxNWp0CBrek49igO2O1Sojhe0wfFFKRukiuxkFZwUJwRdI
	 DyHL94+h33Vmqjsk2YB9mdmTpAbu9KDJ0eg2HWQ/pY+FW0bQPfLkoRC0TUNdnkxT8K
	 y6xd2olwbXBdfwC2q7ubaFcmcCQKXQ1jSjWieOZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgGBGTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 02:19:35 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45]:41016 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgGBGTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 02:19:35 -0400
Received: by mail-ej1-f45.google.com with SMTP id dp18so27834620ejc.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 23:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KI1xByR8EdweHRLmqVp5qJFfLoJv1RlZqf4LrtxTZZM=;
        b=q7CmMA87d1Zuz6FIZ/BGtV8lP/MyyMednrHQRUyQG8btlBXMU9B2vWNkDfpWalhf9P
         bOgj68tJ+TRmPeE69iw5eICSaySMydOLWvsoHT/5G9fmT6zSX+eeY5yfM8STd/jq7vd2
         BkcD4XMp8Ej5exJdZNSgMsIAnjAoNF7sIp3J/96ZT6vOyKbajo9OAS7r7p804YV2vSbH
         Rfz5sN768ygNx9OFmWCbiZoBLfoIpwF4semljfszyTDMI/gY4AsBIeRDhCvz6+F26z0C
         wfkmCTWmBGCenJZ/hP7iIYjnLbYWMnbFBRm72HLCj25V0kcZkC2+lJeJ92YdXOYOLwKP
         X1Gw==
X-Gm-Message-State: AOAM531i6LFX8lLYuc8tyvU/+ot4J8ZWm4Oe0nU6g4wjKcP4D9QDAOyr
        hMX+pLwWX+s1SPwfDuHc5B4=
X-Google-Smtp-Source: ABdhPJzZfQ/Vzu5+dRVQkkNl0kWBWztA+Fk3jN9N0Ylyp4s2Cn6jrsAZ5Vcgq6iJfuiL4Ft9VS55sQ==
X-Received: by 2002:a17:906:33ca:: with SMTP id w10mr18728327eja.171.1593670773586;
        Wed, 01 Jul 2020 23:19:33 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id u19sm9559612edd.62.2020.07.01.23.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 23:19:32 -0700 (PDT)
Date:   Thu, 2 Jul 2020 08:19:31 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Chris Down <chris@chrisdown.name>
Subject: Re: BUG: Bad page state in process - page dumped because: page still
 charged to cgroup
Message-ID: <20200702061931.GB18446@dhcp22.suse.cz>
References: <CA+G9fYs=3UG3k-2trqQuB-gJh9D1YygkNQ4qWiHtcaRMSWTmrQ@mail.gmail.com>
 <20200701082904.GM2369@dhcp22.suse.cz>
 <20200701184552.GA61684@carbon.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701184552.GA61684@carbon.DHCP.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01-07-20 11:45:52, Roman Gushchin wrote:
[...]
> So it makes me think that somehow memcg_kmem_enabled() became false
> after being true, which can cause refcounting problems as well.

Isn't this a similar class of problem as
http://lkml.kernel.org/r/1593641660-13254-2-git-send-email-bhsharma@redhat.com?
-- 
Michal Hocko
SUSE Labs
