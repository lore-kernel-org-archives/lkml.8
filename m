Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBEBC34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240C120656
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/gdLYXD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgBQRPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:15:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42548 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727976AbgBQRPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 12:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581959753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=So9XPv62WRRlQlobfjbv7DGM07vzxCapcWtJuCnxFtQ=;
        b=J/gdLYXDrdFqP63s11JHB+M+yMo+e7jPxmfqR55S1v5ki5pSbp1ML+ta68HhwPEObA+uyq
        nbhAF3IqPPVk+uQkNBtUW90dkad8aIscVtz/fbv30A3qSqY5j33oIDKrksk9nttdf4qfYN
        AY18T3Ts7Nq6aDy2tkgokkiY0y9VS5E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-6UqmIXZEOUWgqSpYkW69TQ-1; Mon, 17 Feb 2020 12:15:51 -0500
X-MC-Unique: 6UqmIXZEOUWgqSpYkW69TQ-1
Received: by mail-wr1-f69.google.com with SMTP id a12so9265103wrn.19
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 09:15:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=So9XPv62WRRlQlobfjbv7DGM07vzxCapcWtJuCnxFtQ=;
        b=oDqq9O2GORn1NP0Txr3fXYAQugbvLrFlfrZLvlVS5ofgAqMG9fA3Byde4BbyQy5xd1
         coO1eoDOuhohVFL3Jd1yFvb4MxEh+l+7ctUa5MQTlHo/SoZcjPwXAxQz9svZMqxMgkpO
         mYqCDs6okkJ59/bl4x4ZvZFuKJqfZ7W6G3KMcpqEU6dgqo9Pn9MleoXmkheGGywqbT94
         K+zqTos9xnAuDz8h0mcof/NwRZk77ITjja7qs8C6qb4Jtv/6GF0zUGbRSTBtnMwJUsvD
         fos4dNBXE3jjei2lKZ5CSubwn5tqUJlWT5zhwSnU/eJ3ZWxxDH1Fzf5GSShQiMQKRe1D
         ZkIA==
X-Gm-Message-State: APjAAAXnjsvRyrVXdSf/9XCKrEtponO8HYSOZHuZbPvVhEBZmqaTPSiX
        micKX4rNjHcnT/jaIBwahGkcTwgsyUqBeOQVeCLA1g1IUWbNUzkuWEUjTfWibqR2lk17QJpa0OY
        ohqmHFXiYZJnOx33oeE3CUDr4
X-Received: by 2002:a1c:9646:: with SMTP id y67mr73762wmd.42.1581959750544;
        Mon, 17 Feb 2020 09:15:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqz7y8IWxspRQy16pPYhFQi9maKhxPLla3Ezv35ZwrJ/KCJ6PiM5kALcG5Usi+8wrJWxGKchZQ==
X-Received: by 2002:a1c:9646:: with SMTP id y67mr73732wmd.42.1581959750239;
        Mon, 17 Feb 2020 09:15:50 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:59c7:c3ee:2dec:d2b4? ([2001:b07:6468:f312:59c7:c3ee:2dec:d2b4])
        by smtp.gmail.com with ESMTPSA id x17sm1883439wrt.74.2020.02.17.09.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2020 09:15:49 -0800 (PST)
Subject: Re: [PATCH] KVM: Add the check and free to avoid unknown errors.
To:     Haiwei Li <lihaiwei.kernel@gmail.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <aaac4289-f6b9-4ee5-eba3-5fe6a4b72645@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <33cd2fda-f863-82be-5711-8c9e4eaa7971@redhat.com>
Date:   Mon, 17 Feb 2020 18:15:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <aaac4289-f6b9-4ee5-eba3-5fe6a4b72645@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/20 22:02, Haiwei Li wrote:
> From: Haiwei Li <lihaiwei@tencent.com>
> 
> If 'kvm_create_vm_debugfs()' fails in 'kzalloc(sizeof(*stat_data), ...)',
> 'kvm_destroy_vm_debugfs()' will be called by the final fput(file) in
> 'kvm_dev_ioctl_create_vm()'.

Can you explain better?  It is okay to pass NULL to kfree.

Paolo

> Add the check and free to avoid unknown errors.
> 
> Signed-off-by: Haiwei Li <lihaiwei@tencent.com>
> ---
>  virt/kvm/kvm_main.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 67ae2d5..18a32e1 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -617,8 +617,11 @@ static void kvm_destroy_vm_debugfs(struct kvm *kvm)
>      debugfs_remove_recursive(kvm->debugfs_dentry);
> 
>      if (kvm->debugfs_stat_data) {
> -        for (i = 0; i < kvm_debugfs_num_entries; i++)
> +        for (i = 0; i < kvm_debugfs_num_entries; i++) {
> +            if (!kvm->debugfs_stat_data[i])
> +                break;
>              kfree(kvm->debugfs_stat_data[i]);
> +        }
>          kfree(kvm->debugfs_stat_data);
>      }
>  }
> -- 
> 1.8.3.1
> 

