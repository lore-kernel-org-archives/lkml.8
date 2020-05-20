Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53061C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A29320874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTWlThUu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbgETX0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 19:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgETX0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 19:26:31 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7DBC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:26:30 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id i15so4823364wrx.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=XQj0KuafA6rqxjjwjiH0uiqBGMfrXq9B8u6LHiRahoY=;
        b=XTWlThUuLFfp0AXcYsOWhbDBsC2jigF2wh06CcO/RNWQ1mPqzq2JV1awnIPu/gMSW4
         ZrxLpbgThc+NwB7ZZFA2vb8Lu9lTkRtwuU3/+Cftj9C+RtG9gp3DN0kKEox6XYv6Cjgu
         mRbm/7RL8ZmrGytfmWZQx+awifYXzS2424XwH4I+oa835meQ5zuU8SVOABFNTx8YAiNR
         yFa0jtiEc3NHKQSyb8TTJZEg4Q3qY4en1q4LpkA8RTrlPLbz/mt0u0ZFyjl/fJiKg7Hb
         9iD8qt6+LRy9jEEkYOFRw6fg+HokyHwarPaJvkY3wWg2P3kwapYc24/yyi++/YwgDt4X
         qvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XQj0KuafA6rqxjjwjiH0uiqBGMfrXq9B8u6LHiRahoY=;
        b=V13D6Ku369BhyFcnQ4qS244pyYS8364eT4Ce8Q+9tBnyMowpz3kb4+8IzY4ZHcs5bR
         D/uisKDZuraVcDoDqWNrDraQJQLUITYNr66SCTY6uLKnLB5TNfDi/3XAEsB8Njj//4cy
         S5tXCUzPRSCVNJC7cxLbujIjIZXD6jhkCNvquT3l7+tdasc41t1m0h/tO5p7r5zCa9wV
         /ahXNZPg0Kc3I+2aDeGBRkcglWppGjXNdUM1fKHYe3e+CRSX+85c3QC0FOT97249rY5l
         DuB4vItklzqMcwJ+HO5dwSpMLGH47UaqM5/Oboj8ywK+pPx1dglhWtKLbzb+UYInUFyJ
         YrWw==
X-Gm-Message-State: AOAM533iVEhIp2rIbA/evWnm85vOhQqkWE+Z2Yc4cm9xHUj1uE4/Pyl9
        DA/C72t/vwfwb2aA17naZA==
X-Google-Smtp-Source: ABdhPJwS0Oc08++7oTKH4IYWa8YQ4ljm/jdHQ4MxgGfEuLFVwJLFyp9sloQn8AlZ3oJWGJPYc/4+nA==
X-Received: by 2002:adf:f5c4:: with SMTP id k4mr5707115wrp.23.1590017189567;
        Wed, 20 May 2020 16:26:29 -0700 (PDT)
Received: from localhost (42.red-83-37-136.dynamicip.rima-tde.net. [83.37.136.42])
        by smtp.gmail.com with ESMTPSA id u7sm4398657wmm.8.2020.05.20.16.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 16:26:29 -0700 (PDT)
Subject: Re: [dm-devel] [PATCH v4 0/2] Historical Service Time Path Selector
To:     Gabriel Krisman Bertazi <krisman@collabora.com>, agk@redhat.com,
        snitzer@redhat.com
Cc:     breeves@redhat.com, linux-kernel@vger.kernel.org,
        khazhy@google.com, song@kernel.org, dm-devel@redhat.com,
        mpatocka@redhat.com, kernel@collabora.com
References: <20200511163910.3778467-1-krisman@collabora.com>
From:   Xose Vazquez Perez <xose.vazquez@gmail.com>
Message-ID: <ee987451-6d17-b978-809e-e0fe56dc13ce@gmail.com>
Date:   Thu, 21 May 2020 01:26:27 +0200
MIME-Version: 1.0
In-Reply-To: <20200511163910.3778467-1-krisman@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/20 6:39 PM, Gabriel Krisman Bertazi wrote:

> This fourth version of HST applies the suggestion from Mikulas Patocka
> to do the ktime_get_ns inside the mpath map_bio instead of generic
> device-mapper code. This means that struct dm_mpath_io gained another
> 64bit field.  For the request-based case, we continue to use the block
> layer start time information.

You should add some info to the multipath.conf.5 man page ( 
https://git.opensvc.com/gitweb.cgi?p=multipath-tools/.git;a=blob;f=multipath/multipath.conf.5;h=05a5e8ffeb110d969f3b2381eb3b88d7f28380f6;hb=HEAD#l189 ),
or none one is going to use it.


Thanks.
