Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A751BC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 20:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82038206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 20:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="FWKrZOV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgGYUXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 16:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbgGYUXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 16:23:19 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50367C08C5C1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 13:23:19 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id h28so9394615edz.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 13:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I0Th57xgtfkchmcZxsB458zve0k9vknOwyUMP9v2Iqc=;
        b=FWKrZOV3H27CAjvjAJeDsyKQLA5xNfO3yYIziGjYBC73EPCiootSOYerRqnltG7Fm6
         7hJpcxxZN/xEVegMZtcFlhGL598qkPpSBtyawL5CNBgLgQy7+oZ1AxBnNN41OXwtnUAh
         h0JU/5HSVmkCNFmgzAxRJ+P9AsJ+79WWGW92I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I0Th57xgtfkchmcZxsB458zve0k9vknOwyUMP9v2Iqc=;
        b=JqfvsWvIVhcGojNe2RlQW/vvNvn4aXsVGBmTBdTAPgQUYvV+DL2TSqCkGb6qxGHrZX
         pVTgHjIoxeh8hQAqgsGrYaJB4Jy8F6gCDmoOQesezui9rDAm6jUoqdaK2f9FZwFIXRwD
         4Z9GukGy8RSJB417n9nPGZczzr3sUCNMYtUwiNLAe6QOS5Gomb6R5pUFc/cHnI4LM7v2
         g29A1p8esT8wTLoZGX3m+gRszk4JdjBWyhByx1aozAuXmaqgJoAGBOK9uAqgpjwc/5Rw
         BEWCATawgE4S7liq8K0KCBCYaqtyHVw9Aa+QOmO+J6Tqq2rHu05axH2g3PPjK4WgbGJ/
         LAPQ==
X-Gm-Message-State: AOAM530bTFpe8oKnSDwlJ3TAzB5+/wWovXMD0qLfNLeY8qRLYUSLx8Yh
        zPYBY/dqTpdck+JpeuRbJbCkOA==
X-Google-Smtp-Source: ABdhPJw/VbbF6tHZ8NOmdYEdOvt/UrR9OBrgYqtAuEXX/5/ArYD5dIF/TN1Y/MIoqFdV7ZJCRvMYRA==
X-Received: by 2002:a50:cf43:: with SMTP id d3mr15290801edk.40.1595708597833;
        Sat, 25 Jul 2020 13:23:17 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:5be3])
        by smtp.gmail.com with ESMTPSA id rs5sm3399321ejb.44.2020.07.25.13.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 13:23:17 -0700 (PDT)
Date:   Sat, 25 Jul 2020 21:23:16 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Gaurav Singh <gaurav1086@gmail.com>
Cc:     Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [cgroup/testing] cg_read_strcmp: Fix null pointer
 dereference
Message-ID: <20200725202316.GA349701@chrisdown.name>
References: <20200725181506.20199-1-gaurav1086@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200725181506.20199-1-gaurav1086@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gaurav Singh writes:
>Passing NULL in strcmp will cause a segmentation fault.
>Fix this by returning -1 if expected is NULL pointer.

Did you actually encounter this while running the tests?
