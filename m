Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B11C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2682C206DC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2rzy6le"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbgFDQdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:33:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30854 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729115AbgFDQdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591288418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rS8D/JFOWrRwFrYArK0CJleHBlqLOjsoPyc8lfn6ZAc=;
        b=Q2rzy6le7OQRS6edJyg+QPvocKG3Ew19tEB8uHi7MsCLFDgKYwnx009JLC/OejfgyrIfGN
        NCT9ZSWvKPcEKIAOL7mZZJSJYuxKIpgnqQghs3oiK62X/rCCMuxo66uNj7d7lUJ/n+Q+4w
        pHtEDbKiAvguVIiLAMLMP5nJucTCsSI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219--aeOGW7jN2ycM-qA41Y7AA-1; Thu, 04 Jun 2020 12:33:37 -0400
X-MC-Unique: -aeOGW7jN2ycM-qA41Y7AA-1
Received: by mail-wm1-f72.google.com with SMTP id k185so1949358wme.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 09:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rS8D/JFOWrRwFrYArK0CJleHBlqLOjsoPyc8lfn6ZAc=;
        b=JsvSmq7x8eagE4CavrljjJnhi1Ci0lWeycOMug20Z3cBwMk7rTq4y4anpWi9RPvK8R
         Njk1CtibELIP5Z+PCF8kGWi7H3WNCijW1k0N1v6OcsUr641/9jbKbBn11kgqXhhqyXRf
         EQAlYyUP2iLxftVIcOoVnKF+hw7KRtBLEmgGbjHgD4ipreT/Ju3SA9Xv/OBe2QP5pxEA
         RdRParIp0YltJfvcTVtw7q1XuHpn49sHKCzZbVwlVIMKK5yu+4JdpNQbq3Ar7v/9Iok6
         R+SSQ0yK4o6X977B/IfKEWTZSKGOq5D595lCJYfu/gZdtwVlZaI2ZYqodEt6ynuIGl7s
         MXRg==
X-Gm-Message-State: AOAM531ZP0oe9ESwubm/lvH7ryIsqHfCmuZUBYsAMunVLo0WdDTQNJbe
        ksgGZtkzyMN0Ct/QCgykQISQMp4v35SHSs+TlEtGQzMqmseTta+m+9H7tZ2Tjj/1Ywxe+s6wS0X
        H55Z/08I1Xd60f62+lwfDkQWm
X-Received: by 2002:a1c:2457:: with SMTP id k84mr4481319wmk.96.1591288416181;
        Thu, 04 Jun 2020 09:33:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGLvx77NfrsgkT65LvDduqV0L/xtQtvXitGjis7X05sQbwKlDzt50915nPUtGkF1/DNBuxzQ==
X-Received: by 2002:a1c:2457:: with SMTP id k84mr4481298wmk.96.1591288415922;
        Thu, 04 Jun 2020 09:33:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0c0:5d2e:1d35:17bb? ([2001:b07:6468:f312:a0c0:5d2e:1d35:17bb])
        by smtp.gmail.com with ESMTPSA id v2sm8619411wrn.21.2020.06.04.09.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 09:33:35 -0700 (PDT)
Subject: Re: [GIT PULL] First batch of KVM changes for Linux 5.8
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>
References: <20200603173857.1345-1-pbonzini@redhat.com>
 <CAHk-=wjC21siUGvy9zpVOHfLRe4rwiT-ntqqj3zN73qtveKjpQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8ffbd4d8-5baf-c2ee-8728-cc73794ed863@redhat.com>
Date:   Thu, 4 Jun 2020 18:33:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjC21siUGvy9zpVOHfLRe4rwiT-ntqqj3zN73qtveKjpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/20 00:17, Linus Torvalds wrote:
> On Wed, Jun 3, 2020 at 10:39 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>> There could be minor conflicts depending on the order you're processing 5.8
>> pull requests.
> It would have been good if you had actually pointed to the reports
> from linux-next.
> 
> As it was, the hyper-v pull request did do that (thanks Wei Liu), so I
> could verify my merge against what had been reported and this didn't
> take me by surprise, but it would have good to see that kind of detail
> from the kvm pull too..

Ok, I'll keep it in mind.  Based on today's report from Stephen, you
will get also a conflict with the s390 tree, and a semantic change
(build failure) when Thomas sends his large IRQ rework, due to the
removal of the second argument to do_machine_check.

Paolo

