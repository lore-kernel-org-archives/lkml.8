Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D68C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A30E20707
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UEx+2txC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgFOHNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:13:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44768 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728251AbgFOHNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592205186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E3++9fAWe/b7XlLrTToP5Y8eC+hZgKd4hA8M+NDkd1Y=;
        b=UEx+2txC7oqVC0LhQ01NzU9fWLp6XuSOXhMHuWnvBd5Ki5hCW4uRRRmFd5XoF+bkuQx0jD
        rlDqzbQKJfQrWsktxZUYfYt/XdVr7i7ztZ22/Lky4gVcLmJtuv/vgGW3gI7JEEF2zO6H7A
        +ZYY/RfOODn8/BFwUfSFEmGuWkd8lk4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-T-oP4H5SMq6AWMVP-7ZYTQ-1; Mon, 15 Jun 2020 03:12:59 -0400
X-MC-Unique: T-oP4H5SMq6AWMVP-7ZYTQ-1
Received: by mail-wr1-f71.google.com with SMTP id c14so6647251wrm.15
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 00:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E3++9fAWe/b7XlLrTToP5Y8eC+hZgKd4hA8M+NDkd1Y=;
        b=S61rAWi/QkbuCkI4OeefxUjQkLh6Tgmf6Cgx5at4+2EBqm9uDBrjafibe1npNCLoKN
         7BOiWEf+CrCFM7mTdu4V+tObzzWrKJQCv4c+VP8C+XOMt1xTqOw0IwLo8ZGAWgsEd39i
         8YhUS+IOUb1oeeOgMnNT6xcBQXP5FTzyDvwVAUS9ENNNtBr8HxcRc+/JSKn6KeYqLWH7
         hNMEKvd8Z+RR+0mzVV0U2pWQ54OhvAyxN3NcSYw7Q9y9YuiZgwFRDeQ2utXM43u9Tnsu
         7fKXuyANus3sykFUMrM5yXA7gssimp0GTAXMwpakwUdsw3FiHUAiM9jcIAn7VzTF183N
         6M+w==
X-Gm-Message-State: AOAM533eAfnDvO2z6XJ5Z3HVfjvU8SNnyd7ugXsQagS+IwHEad4FuA4u
        odDbvwFt79kPe4SWd6RArKQMx2Ui6L6y2/SL8OAIisuc3mnaTrQi9ZBI2U+658TLl7aH1eZnfhc
        V6XjNeQ9f/+nGO6Sk2Hdm+wuw
X-Received: by 2002:adf:fec8:: with SMTP id q8mr28353159wrs.2.1592205177933;
        Mon, 15 Jun 2020 00:12:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSZe918tll2ZSyHGEdKwQVQaOk3rhZPCzlb3iWg1Kr0iPZ98GBO0leCPdeCExwntcSaXXFOw==
X-Received: by 2002:adf:fec8:: with SMTP id q8mr28353140wrs.2.1592205177700;
        Mon, 15 Jun 2020 00:12:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c461:afc9:1:2046? ([2001:b07:6468:f312:c461:afc9:1:2046])
        by smtp.gmail.com with ESMTPSA id a14sm23889987wrv.20.2020.06.15.00.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 00:12:57 -0700 (PDT)
Subject: Re: fastpath_t? __no_kcsan? Both?
To:     paulmck@kernel.org, cai@lca.pw, elver@google.com
Cc:     linux-kernel@vger.kernel.org
References: <20200615042002.GA14788@paulmck-ThinkPad-P72>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0bdd3592-24ae-ab35-a6cd-40d842b127e0@redhat.com>
Date:   Mon, 15 Jun 2020 09:12:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200615042002.GA14788@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/20 06:20, Paul E. McKenney wrote:
> 
> I get the following conflict when rebasing 39a8c47635b0 ("kvm/svm:
> Disable KCSAN for svm_vcpu_run()") onto v5.8-rc1:
> 
> <<<<<<< 6c410247efb2d3907b508a2448ab9ab1c86d938c
> static fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
> =======
> static __no_kcsan void svm_vcpu_run(struct kvm_vcpu *vcpu)
>>>>>>>> kvm/svm: Disable KCSAN for svm_vcpu_run()
> The "natural" resolution would be this:
> 
> static fastpath_t __no_kcsan void svm_vcpu_run(struct kvm_vcpu *vcpu)
> 
> But does that make sense?

fastpath_t is just an enum, so

	static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)

Now that KCSAN has been merged however I can do this change myself.

Thanks!

Paolo

