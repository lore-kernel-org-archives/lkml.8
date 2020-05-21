Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB810C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 796C520759
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="i2gnUCbS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbgEURJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 13:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728581AbgEURJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 13:09:13 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00C0C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 10:09:11 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d7so6023891qtn.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 10:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3MU9IkqS+BLUcfN9GchjkQ6nlyviY4AlYVd5E3vN+j0=;
        b=i2gnUCbS9oKe3leRPnwVoRevCcbxje2AdlR9f0Syg/kpivOJMVhIwzCr7p6luFW6as
         +WCJ22vuZr9UiKWGI5nWK/839+nqYWAeIw70VWGRwnGen85rrr7QJwWkeOvUAimcnYCq
         pUJIdNTBz9fxTJD/ADtVVv2tVzSLFdCDXyLcIUWK3v0pDwelixva5S1MoSCaknhWgWv+
         SNERz/v9le+cGdhLgW9KmYB+7q+d+nzBj7JosQyNVDvBGA+oXVn2u1/4gm99mjprvUE9
         8UaT7AatU+9M/1KzFx2DswUpjVl6ZKpM6qxh6td/noVVVBHo5rL5E+PCIAsITwp699Vd
         AzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3MU9IkqS+BLUcfN9GchjkQ6nlyviY4AlYVd5E3vN+j0=;
        b=T1o33ViGeBH+46zew7eIh2RhpbnaNXsZJhFm2bTCCI8nv2wmBIEbwtyajhMjkGnVHG
         d0KbYzgJ+qAnYn+gXmsJjuZDSxu9ZYcixquN7oBEO2LteGL2YhYPDuqyk+mD7oW0Qv8L
         MWmnzBGXq39Mw5HwHki0jf9qyI/d4f5kZhNRI9RD4qt+rqFuWbb6ZIFVD2xPZ7hw0IWe
         Mhjv7o3LRDfZIMqqVJrAsbLivvOORJtzwS9YC6rtLlqSMvfPP9AF75Zm1JzgKq7KJM4J
         898eLgAPspbIMzdL1a+9JlVwHXMg/LFit9AVqdHmJ4teX8UqiIJU5KTWRVMLGh+ntF5L
         Eu7Q==
X-Gm-Message-State: AOAM531Thk8lYhif2PJz8jjKrnadp7izr4p/thh5P0/QFz2vNYX+CNFd
        nU+J8bUXNWPLdfBJCGBWiek0ZubIG73Yw7xDneXAgw==
X-Google-Smtp-Source: ABdhPJxIV+9MqTyhFhp7uNn4PmSjtHyz2Tgn6CqCypla9gMwmSmVBU83xxn/aSrQf2JAa1KNxuNQ4s4QbrD0sBMlGO0=
X-Received: by 2002:ac8:5693:: with SMTP id h19mr11528025qta.252.1590080950102;
 Thu, 21 May 2020 10:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200521162518.1809995-1-lma@semihalf.com> <3c89e614-81f5-ba87-19a9-fbe9f5c73925@linux.intel.com>
In-Reply-To: <3c89e614-81f5-ba87-19a9-fbe9f5c73925@linux.intel.com>
From:   =?UTF-8?Q?=C5=81ukasz_Majczak?= <lma@semihalf.com>
Date:   Thu, 21 May 2020 19:08:59 +0200
Message-ID: <CAFJ_xbr8TN3ynfELJ3NQnkuRg0VRbkjB7=Cyb8yu2L==JGXJiw@mail.gmail.com>
Subject: Re: [PATCH v3] ASoC: Intel: kbl_rt5663_rt5514_max98927: Split
 be_hw_params_fixup function
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Bob Brandt <brndt@google.com>,
        Alex Levin <levinale@chromium.org>,
        Ross Zwisler <zwisler@google.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Radoslaw Biernacki <rad@semihalf.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> don't add a new dailink, this is not right.
>
Can you advise a better solution how to assign different fixup
functions to mic and to speakers? I was looking at "dmic01" dailink in
skl_nau88l25_max98357a.c as an example.

Best regards,
Lukasz
