Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CBDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2335206D8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vsK2k62d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgG2UuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgG2Ut7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 16:49:59 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E33C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 13:49:58 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id z6so26052096iow.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 13:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R5Zsab5WHMd96BIHQuVzitAMA+epsJ+V0jZwHn8dA5o=;
        b=vsK2k62dcrIC+j7NuJu5tFJVZZLCoEipXlUeyWrPqMetWdM/dFYlyFTItrpCVRRYvD
         VY2eDaigclW15J9jys61hsDYpfO+2v6patqdTlqUT4UHlVYyKYBSlZLrT+XIhhTPe0Pc
         js1yGKwHzPyk4A/guwrvprqdz+dTRmbYFs5oN59ESFzWQ0nmF2QmBmWhuDumN+oB55+h
         ATMY+qovO2foOZjlHo0kUVUGq/OuuEcWVQsJF6AtYWJkx9FgbMN+MuqSz7Oo/zI9MIYc
         B0K4fzcPEB0ai4a7YBsC3cUHABzrUFqmsTJum9AEl+asWvNQv1tFVhjCig9wDD1M94I8
         pfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R5Zsab5WHMd96BIHQuVzitAMA+epsJ+V0jZwHn8dA5o=;
        b=kLli2EbF6Jgayhe7vIvLLSO/7xKbgocx7OEoRTkHxFK6XBU+y5w8c7oQzpMP4SRT/t
         fHW4Pf2awttzL2UmlsJCllVCN7ccsgmtzeF9RrDF9jBTRrwnVhfN51n+g/WHC08IQ0tN
         vSEwEfOlfVYWupOMTnTR7kdPIMFK0VC9PcEat+pQHOAUo0+tGwGEDSnrbm/RBJTRKRQz
         Uz5GoIdXYWmVm1pkXCfDef/cDpSnk+1400oMt+fpY9BHpF6LKdi9ZvwafZqJ0Td4G+fa
         be0mTH/MnVlvf8InigGFK3CNoUYwdkqyAZg8mwBK7d8L6rB7s7HDkizkDImj5zSlax0l
         xdPQ==
X-Gm-Message-State: AOAM5326XUZuurFJ1swHmkJ80gId+iWfei4CGvR/2pYUkUAgR2wtlbde
        nwIq0DLl/0SO7M237OLnPDJy4grM3XJ9Uv6S08M9Bw==
X-Google-Smtp-Source: ABdhPJykP3cigdlHoKqG9HXBVHxb00S2uMk0Rd0zeejwEgCfL36RmUxUIv9NVpE6v49yEqEYKi29HijrG8opdjzLfc0=
X-Received: by 2002:a5e:8611:: with SMTP id z17mr18066051ioj.177.1596055797247;
 Wed, 29 Jul 2020 13:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200728004446.932-1-graf@amazon.com> <87d04gm4ws.fsf@vitty.brq.redhat.com>
 <a1f30fc8-09f5-fe2f-39e2-136b881ed15a@amazon.com> <CALMp9eQ3OxhQZYiHPiebX=KyvjWQgxQEO-owjSoxgPKsOMRvjw@mail.gmail.com>
 <14035057-ea80-603b-0466-bb50767f9f7e@amazon.com> <CALMp9eSxWDPcu2=K4NHbx_ZcYjA_jmnoD7gXbUp=cnEbiU0jLA@mail.gmail.com>
 <69d8c4cd-0d36-0135-d1fc-0af7d81ce062@amazon.com> <CALMp9eSD=_soihVJD_8QVKkgGAieeaBcRcNf2gKBzKE7gU1Tjg@mail.gmail.com>
 <13877428-be3a-85a8-bcdc-3a21872ba0e6@amazon.com>
In-Reply-To: <13877428-be3a-85a8-bcdc-3a21872ba0e6@amazon.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 29 Jul 2020 13:49:45 -0700
Message-ID: <CALMp9eRiWCRT7fXbVgE52E=KH9m8nz-OQxoexTUocP8hX-fHVA@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Deflect unknown MSR accesses to user space
To:     Alexander Graf <graf@amazon.com>
Cc:     Aaron Lewis <aaronlewis@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Raslan, KarimAllah" <karahmed@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 1:46 PM Alexander Graf <graf@amazon.com> wrote:

> Do you have a rough ETA for Aaron's patch set yet? :)

Rough ETA: Friday (31 July 2020).
