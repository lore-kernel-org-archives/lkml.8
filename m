Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A155CC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 12:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EDB72173E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 12:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="DMiEa56R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgBRMm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 07:42:56 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]:36229 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgBRMm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 07:42:56 -0500
Received: by mail-qk1-f171.google.com with SMTP id t83so2317519qke.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 04:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=HXwLXPC3uj2FBozvtZYRTOCinHGN6/mECOLa8GGzXbw=;
        b=DMiEa56RcS6t4bfviWcOwkMg7hVCD0v6dp3izIiWck3+NoVCJkw0oWwtBX4pQZSo8w
         9hgJtRN14UsC3sxU5kIaOo24XZSOUgpJt+ppUqPWXuHYfUrvaZxxcavgvZM3eBq+wc+g
         gnWNWf/2l4LYB5IyBBVv6ZmNW8aBcTnuxqw07nQJjrRLsuOPIrdRc27pqAfwCmfaYTVC
         CfAXR1/XjHrodMOB5SHhBgs3j1O5QOE+NWKIQqnm6EIYsU85ff0WfJBMU6ZCC3UScvgK
         OAKoXUJcqoAihaBB/5s6wJPJ/vhSe1l2qEhO9YyrY3SLIKxYTWNVt8Rmx7eETNg9TBse
         A6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=HXwLXPC3uj2FBozvtZYRTOCinHGN6/mECOLa8GGzXbw=;
        b=Bwl/NSo5ze96me+7V4zBBVIseQUBTC7LakqpWNdNXy8iMj/KScGhXzninrkr/Gls7h
         8FVBFiOVBoGRP4W3tBpGOzFfPZI5Kl3Z0KuXXsjGOTVlPjMN+klcNaJBiVp0B7Zb3QPN
         jra+R5xds582kA3JOoOXI5Kbm22wI0umVvfhHWHOVTlRGxka4Bj3IlcMaofmHjwkz2rl
         BXUbRBeaHMb60vdgg+i2wY45Y5Gxlv+JLRW+BKyxBSxJF3LVZYq/Z5LUzU+3OK8zDc52
         OvmY8j2nGe0kqFz+yqiIygApuvmlSwGu1o04m1UkzWK/ZclwRVLhndejOkZb94ldc+Fe
         dSIg==
X-Gm-Message-State: APjAAAUzjzmEtz5E7RC4RZJS3/gBcO1g6h/3ylpvwd3Ozi1AkMno26CE
        p3uHfC9sk9QEd2zebMA0UY0xtQ==
X-Google-Smtp-Source: APXvYqy6Wm7sXU7W5+mucvMyXdyd6lZPrkO3Ol/mLD3Hrklp9U/tJLSKHsmzQkfj3CnheHidAYAp8Q==
X-Received: by 2002:a37:ac17:: with SMTP id e23mr18514275qkm.80.1582029773807;
        Tue, 18 Feb 2020 04:42:53 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id l10sm1786508qke.93.2020.02.18.04.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 04:42:53 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next v2] mm: annotate a data race in page_zonenum()
Date:   Tue, 18 Feb 2020 07:42:52 -0500
Message-Id: <4F681D4B-8A43-4312-8085-BC679D3D83F4@lca.pw>
References: <20200214161639.GR2935@paulmck-ThinkPad-P72>
Cc:     akpm@linux-foundation.org, elver@google.com, david@redhat.com,
        jack@suse.cz, jhubbard@nvidia.com, ira.weiny@intel.com,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200214161639.GR2935@paulmck-ThinkPad-P72>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 14, 2020, at 11:16 AM, Paul E. McKenney <paulmck@kernel.org> wrote:=

>=20
> Any of the three options above would get you into -next quickly.
>=20
> So just let me know how you would like to proceed.

Unless Andrew has any objection, I think it makes sense that you pick this u=
p as it is pretty much a low risk patch.=
