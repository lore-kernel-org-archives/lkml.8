Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE74EC3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC00D208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="PrOSIOOC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgCEMjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 07:39:11 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33096 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgCEMjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 07:39:11 -0500
Received: by mail-wr1-f65.google.com with SMTP id x7so6849385wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 04:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=pYWrtSZ5I3uW1QcEhTGT9GeK1NCq/e+RGR3zxxP+WH8=;
        b=PrOSIOOCzAl97oAtiDR0UP+H6xIp8nuvNcPwu1B9MRV5SNZkj/OXTH3ao7KxY/i4+y
         bX75B/cDDDEmTKv0tJH/Fb1POzm9sJC501FXHMX08/7MDbk2e26XFUH6lR9H5xMQBA2z
         osueMZgUXoulkK1hilnXuTY43pvM/KseWfARA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=pYWrtSZ5I3uW1QcEhTGT9GeK1NCq/e+RGR3zxxP+WH8=;
        b=mu+1VIoogfzfJRukR6THhKc6TjEhu2ZNFOz5MQt6B9UahbIZWp2QutfHctlkFkSwUu
         8qPW8yNL8nMftCtjyEQkhBHFLqvAvj6KyjBfj0ahzTq/wV8jBh4RJJPzQDLkGhm3mvDy
         44ysOuFp3LUV8rV20N1RMom+4v/TSPpYV8891Do+7R0gXQDlv2NMeoT9F7NasBeQoo2V
         2boIdRuYbUfLosNTq3cxHh2G9h8sla0FDlYJmPniYGRoUaMm/YL8wb+0G0y6QGBX1VMF
         fKUHp6C1vTdkE6CL4hGp3b3JZn/DUQ7/FKBsXoYmZ+XbzTAL+Pyz1ccY6ih5yD7SSSxM
         paZQ==
X-Gm-Message-State: ANhLgQ0tAvc95DxkaQ5t9/sIePLsjUtI4COIdIGX+u3GlNTTZrnG4Sif
        YBjy+8uB42oiGJxG95leLuicTA==
X-Google-Smtp-Source: ADFU+vuoYiIQDL/Bgw/m7qYyZH6LqBF/36vkigdO/cruK1yzrnGewE6H44j7qtWh27KT8oAjQdfkJw==
X-Received: by 2002:a5d:4c92:: with SMTP id z18mr10036742wrs.294.1583411948743;
        Thu, 05 Mar 2020 04:39:08 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id n24sm3455684wra.61.2020.03.05.04.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 04:39:08 -0800 (PST)
References: <20200304101318.5225-1-lmb@cloudflare.com> <20200304101318.5225-7-lmb@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     john.fastabend@gmail.com, Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 06/12] bpf: sockmap: simplify sock_map_init_proto
In-reply-to: <20200304101318.5225-7-lmb@cloudflare.com>
Date:   Thu, 05 Mar 2020 13:39:07 +0100
Message-ID: <87a74vyo0k.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 11:13 AM CET, Lorenz Bauer wrote:
> We can take advantage of the fact that both callers of
> sock_map_init_proto are holding a RCU read lock, and
> have verified that psock is valid.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

[...]
