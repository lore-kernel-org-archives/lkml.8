Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE660C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A271E246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PwfWjye5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgB1KQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 05:16:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28865 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726766AbgB1KQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 05:16:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582885003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eVoGLbtnYzXWlmc48w0t/0qrnxkTvQefS/f9aokidUA=;
        b=PwfWjye5QTLBcABwlf9U/iP6ZBjcDQFk4ZuRCvNKvWDrbGRSzaTyW5PO+uRL2HSZU9Dck+
        +K6CtzyPzko6yFcWA0Z4mOd42q5T8n5uMTDOGbvb2JlRID6xecqDY9x8AMTwqWix4eI3hW
        VDocAQ6ls9uFd/MmppZTT6MgUQCLtPA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-aROSRINmPOmvXvPhI84mxg-1; Fri, 28 Feb 2020 05:16:40 -0500
X-MC-Unique: aROSRINmPOmvXvPhI84mxg-1
Received: by mail-lf1-f69.google.com with SMTP id j204so347186lfj.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 02:16:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=eVoGLbtnYzXWlmc48w0t/0qrnxkTvQefS/f9aokidUA=;
        b=J89qdou+TcF6Tx6dNhHg8SxCokkc1kXYaGgW7TwB8SpKt6qswRm+Sk7Pp1XETFy/0U
         WnqYVG5WKLaTo+G7raaVZEX30vH6gq6mwTMEZHJdrQDpOpq3HgpcF3UKkD4grWQVHZF2
         ZFIMwukp8R2XmBDNpxLCXP7sD3EhD/nSK4tKz5dnvVb8A5DQ2KN3AMW2Oq25k2p8cZ9l
         OWb0/QcaB5hxf68ObDPvFDUdbtQWvfcpcRLy1Ddcb54cEuxZao2pdS6Ld+mLqXeci8Yo
         e7y3W1CkR3sI5Do/NRJhFm+DuNkK9XqLTF3fDa1XuqA6NyEn+oVvQXq+T5ucypick4lD
         2Jqw==
X-Gm-Message-State: ANhLgQ3koK+jkrhqMSzo+kqCq6bvteyIAKEeNELyF9HabV3KdzdWI3p+
        RhVjeuF/khYNBTFFRqbUcg8b7NcgV299fvzm3itr2UQpeFhXBy4dBztKmXtaI9FEnmu292wKOap
        CKa3lpXnTwBJJS6sh6y2A86Mw
X-Received: by 2002:a19:7d04:: with SMTP id y4mr2282666lfc.111.1582884998573;
        Fri, 28 Feb 2020 02:16:38 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvXO5F7cH4hg0ivZxLRqZGLTBjzmF9Evdui+BrIiVguCGiV5KpQodnEEMWnFVLVq1UTeuRPKQ==
X-Received: by 2002:a19:7d04:: with SMTP id y4mr2282655lfc.111.1582884998373;
        Fri, 28 Feb 2020 02:16:38 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 19sm4543665lfp.86.2020.02.28.02.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 02:16:37 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AC741180362; Fri, 28 Feb 2020 11:16:36 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Luigi Rizzo <lrizzo@google.com>, netdev@vger.kernel.org,
        davem@davemloft.net, hawk@kernel.org, sameehj@amazon.com
Cc:     linux-kernel@vger.kernel.org, Luigi Rizzo <lrizzo@google.com>
Subject: Re: [PATCH v3 net-next] netdev attribute to control xdpgeneric skb linearization
In-Reply-To: <20200227173428.5298-1-lrizzo@google.com>
References: <20200227173428.5298-1-lrizzo@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 28 Feb 2020 11:16:36 +0100
Message-ID: <87h7zbuid7.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luigi Rizzo <lrizzo@google.com> writes:

> Add a netdevice flag to control skb linearization in generic xdp mode.
>
> The attribute can be modified through
> 	/sys/class/net/<DEVICE>/xdp_linearize
> The default is 1 (on)

Calling it just 'xdp_linearize' implies (to me) that it also affects
driver-mode XDP. So maybe generic_xdp_linearize ?

[...]

> +
> +What:		/sys/class/net/<iface>/xdp_linearize
> +Date:		Jan 2020
> +KernelVersion:	5.6
> +Contact:	netdev@vger.kernel.org
> +Description:
> +		boolean controlling whether skb should be linearized in
> +		generic xdp. Defaults to true.

Could you also add a few words explaining what the tradeoff here is?
Something like: "turning this off can increase the performance of
generic XDP at the cost of making the content of making the XDP program
unable to access packet fragments after the first one"

-Toke

