Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4205AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1376920656
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="REEPlBea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbgFJUAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:00:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40262 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727038AbgFJUAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591819241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pRtsgZAxObyymDLOXZptKopgjPDlNKhyefsEXrzQ/I4=;
        b=REEPlBeapTnOJ99+6AYXpAK9WtaIgDHE9kqGJ1Q2ByNTB+3YQkTkpOVqvNL0meAw/KdFSc
        i9EywTQJc3yj8f98LHvP+n+jzpp3PaWvTToBPMp1pbtLKbf8Om/UCRsONOsdn2333NEMdJ
        zBbfJF34giq91cokN55Bei5Q8ZvWztc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-go6NgsaPMV-6tsRiaGSi5Q-1; Wed, 10 Jun 2020 16:00:39 -0400
X-MC-Unique: go6NgsaPMV-6tsRiaGSi5Q-1
Received: by mail-qt1-f197.google.com with SMTP id y5so2899937qtd.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 13:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pRtsgZAxObyymDLOXZptKopgjPDlNKhyefsEXrzQ/I4=;
        b=THhnZP7c8rxnTShf5YAlmNEU8hY/4UtRIvvkafkcnFLUDwbcJgJgpVdVvXby/im0mw
         aL6mlRTJREJyzloXGsfcRxaX4Njm1dalQnt0hq27M+v/AHaSbdfVRRT3sDgTbL5x5yUY
         ItzUFT345rqDzasgf37zyPAzwWAtQfSetq/HCjqIfw1SFq+XYyu9eB2SFCZQAXLrtVgu
         k4iFpP+8enc2bqlvr7XXQU2Mrq5EHKAsv/dL/D7PnQBgalwSD4bMikZOn0kbXmZgOg+y
         LkxVzeEVms1d5PSs3TMO/IiG/ua1XeirkbNQjwryixTR5DY34Rvm6fJlTPHttzJ4rzyf
         7hjg==
X-Gm-Message-State: AOAM531oF+OZOs1uExZdwzjpHTvaNVLYqvDN08vDxAGAMdDY/FSjcUXP
        pcXTfgXt0lLme5qIw/0yU/oAZFNbHXLZ7LNoGsp6BGmzHEjdpbAsvNx00iXoS9oGMp7tzz+Z11E
        3GzFzLq+vE2Vi9f1MI0pvRJlp
X-Received: by 2002:ac8:fb4:: with SMTP id b49mr5027937qtk.323.1591819238494;
        Wed, 10 Jun 2020 13:00:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzufTo8WrDTDl54yKLdWR7pe5K6v+H16e02ot8Ki+DcVcjzlOGKWgW5I5q5hVKmeH300x1tig==
X-Received: by 2002:ac8:fb4:: with SMTP id b49mr5027914qtk.323.1591819238304;
        Wed, 10 Jun 2020 13:00:38 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x11sm693401qti.60.2020.06.10.13.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 13:00:37 -0700 (PDT)
Subject: Re: [PATCH 1/1] selinux: fix double free
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Jeffrey Vander Stoep <jeffv@google.com>, rgb@redhat.com,
        SElinux list <selinux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200610181021.19209-1-trix@redhat.com>
 <20200610181021.19209-2-trix@redhat.com>
 <CAEjxPJ4uRG4FiBbyUxQdsLWsz4torr+rst1VKN_Gdk5PqT6Kpw@mail.gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <5bfa5213-7d1b-684a-9e21-488fcbf14b91@redhat.com>
Date:   Wed, 10 Jun 2020 13:00:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ4uRG4FiBbyUxQdsLWsz4torr+rst1VKN_Gdk5PqT6Kpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>> +++ b/security/selinux/ss/services.c
>> @@ -2888,8 +2888,12 @@ int security_get_bools(struct selinux_state *state,
>>         if (*names) {
>>                 for (i = 0; i < *len; i++)
>>                         kfree((*names)[i]);
>> +               kfree(names);
> kfree(*names)?

Yes.

> kfree(*values);
>> +       *len = 0;
>> +       *names = NULL;
>> +       *values = NULL;
>>         goto out;
>>  }
> Wondering if the caller handling ought to be changed too even though
> this should avoid the problem.
>
The poisoning of the returns avoids this.


