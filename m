Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235A4C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01D4520882
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FB4REDJR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgHSNey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:34:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27488 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728556AbgHSNeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597844038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1A3YVzHwJmiHNz1WhEQhMZMMatTxl2bdR9e5Zus2ktM=;
        b=FB4REDJRLTLSWsOhnrXL/eVmelpVfXKCTkc21NLtVpChBOjwMyarNJfGYnW6oOVo++eFMi
        /hq/+RtGvsaP8NaoiinmErr9fREV4inQPknJtb83O1TZfnOtHWFfDHJPkCs2cXnYxQplVy
        F/fAaAjNbDYcock6lhpEQ6El9NhCfHQ=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-nq0xK8UGOIyj2ceLtNLSuw-1; Wed, 19 Aug 2020 09:33:56 -0400
X-MC-Unique: nq0xK8UGOIyj2ceLtNLSuw-1
Received: by mail-ot1-f70.google.com with SMTP id r18so10725318otq.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 06:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1A3YVzHwJmiHNz1WhEQhMZMMatTxl2bdR9e5Zus2ktM=;
        b=UwmG/d7XIivXVaTCLytaxrmLXxeBL0xx/6rqOtYbWj8qNVnGaxDI6Zk5F1RxLc1DBz
         47Abr8TdfWXeQe107uxxXWQakIJ1VZalJ6MWo7wdVhD5skoBgXBAyJ7KrjIK0YtNaI3z
         pnVZ+6ntvDgxkMa8nwVTBUAelDukMqxkYpC3ITiTZjd4xqimTRNxkCgrHabuExTBN6PM
         1+GWEsGgQ2UvLTfvclqrTej+BCmcF4dZvklCXbJuTRlUJ4CfJw6HHzFCNMQY7SlrmAls
         1Pf6OMPki9snBCr9jo3on0I3bbeQpLDErM2N3IagGGviSpaV0Is3FAitis5oITbX49Tz
         IITw==
X-Gm-Message-State: AOAM5317Pe5afsyzXGRw6PXTSZcB+8/x5WlgUCFqzSzoZAHHP5UQ4W2k
        5prWPo8QREkUSyArmsi8eKVUI5f8ZJ/LrjHK8qRHQCiaXwXI2g8rxf+ADQ3HtpqHMSGta6zDwEK
        Y/9ZMn8TnELAuHAZ5NZF4eYD/tSc0vwPkHRtxwYMc
X-Received: by 2002:a9d:6e1:: with SMTP id 88mr18165959otx.178.1597844036069;
        Wed, 19 Aug 2020 06:33:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDK4ZmVu++rFkaYtt43Tpk3Yf8PlFZGZT7z4I0jOccmzf4KD2leJPmhiIIUxoTN+497qRQJkjMR8MX0o9jLYk=
X-Received: by 2002:a9d:6e1:: with SMTP id 88mr18165944otx.178.1597844035864;
 Wed, 19 Aug 2020 06:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200716135303.276442-1-jarkko.sakkinen@linux.intel.com>
 <20200716135303.276442-22-jarkko.sakkinen@linux.intel.com>
 <CAOASepOqRfUafSv_qjUv-jW_6n8G7kZ9yh-2z_Z9sjL_2zqNCg@mail.gmail.com>
 <20200810222317.GG14724@linux.intel.com> <20200818145234.GC132200@linux.intel.com>
 <20200818150627.GD132200@linux.intel.com> <CAOASepNxu0YtSPjXynLaVgyt-S0uSad8HVrNgMNWf+Z7iamPvQ@mail.gmail.com>
 <20200818164353.GH137138@linux.intel.com>
In-Reply-To: <20200818164353.GH137138@linux.intel.com>
From:   Nathaniel McCallum <npmccallum@redhat.com>
Date:   Wed, 19 Aug 2020 09:33:45 -0400
Message-ID: <CAOASepMABkAxMRY7fJr4bAqadYyVrhZkb0BmB8cTcXUL_VmwQw@mail.gmail.com>
Subject: Re: [PATCH v36 21/24] x86/vdso: Implement a vDSO for Intel SGX
 enclave call
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        X86 ML <x86@kernel.org>, linux-sgx@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Jethro Beekman <jethro@fortanix.com>,
        Cedric Xing <cedric.xing@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        asapek@google.com, Borislav Petkov <bp@alien8.de>,
        chenalexchen@google.com, Conrad Parker <conradparker@google.com>,
        cyhanish@google.com, Dave Hansen <dave.hansen@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Svahn, Kai" <kai.svahn@intel.com>, Keith Moyer <kmoy@google.com>,
        Christian Ludloff <ludloff@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Neil Horman <nhorman@redhat.com>,
        Patrick Uiterwijk <puiterwijk@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, yaozhangx@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 12:44 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Tue, Aug 18, 2020 at 11:15:32AM -0400, Nathaniel McCallum wrote:
> > That seems like overkill to me. I'm just asking for one additional mov
> > instruction. :)
>
> I started to consider eBPF since the complexity and constraints of the
> callback look like an overkill and without doubt will be a burden to
> maintain.

That feels to me like more complexity just to move the existing
complexity from one place to another.

