Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6076C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 11:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD42120882
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 11:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="qUXNszkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgAULpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 06:45:35 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32855 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgAULpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 06:45:35 -0500
Received: by mail-qt1-f193.google.com with SMTP id d5so2336700qto.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 03:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=2RAq65fE1p08MEyXCEbcjOGodQ3rvsuPnBMUCzsOXfs=;
        b=qUXNszkrfraMVH0sN6CssRY3CrV5i+a6z/l/iPyFXKM/8qQ+nZF4SmPIVj7nc8xi5K
         Cg97C6gB5Z2+rLZgSMY+ThXdzHxVfecADR654yef5v22MaZprnpqp6X2DJaqq0/SKCIb
         gqU5Wg8+AVJLoZYrR1fBMxsE3OnjiC8DEXP36TivLOWwT8LCboWHo7fGmXDb7EY7weqG
         bfy5kLd7BxFpI+dQ4LOkz3kF8Rwl4oe7P8G958Exlo3j9sL4EuGhVK+xD6pk2X5p42e1
         142xtY9WcoWGAu5objVL+6SJM11kjdO14P5U+nfjaI39YfEjkqAFy5JnstrQeayFrUqg
         0dnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=2RAq65fE1p08MEyXCEbcjOGodQ3rvsuPnBMUCzsOXfs=;
        b=tlJ8CWfd/XNh3bl9rSBrEAFkUQ939K00WPaS7GWBOVfW0wl1O7dnD+gtXIavVwH0PO
         TaUnp4JHtYZL0CAa3iRBcs26Q7tP2jTyKGZ4agLX3I2qVtU/NdjnMa9dJacP9oI5ERLW
         Z/2TPicuqbqgYBNAvx0LFcHgUCV6Ja+NhSZtud4KbBHdgD7ciefduVNs4gW474QmMylV
         IQL8lll6+Zme3eDa5qWHAfm0MJ8JIoY2kKzHZIv6mnhB6ho+t4kXbT9gaVjzNPHVZSM1
         ZHykLMrXHw235NuE/McNEAOO7CMHxCy6KPH9B6jF5DYFWQDYwkZBrAkb7kzeIHBFeU9c
         rgew==
X-Gm-Message-State: APjAAAUqMRxjRsU8CqMpk97jaaqTfMOCwP/4mFeiDAPg3g1NvJ0lXa8G
        z3Bn1r1HnQEXGPbqZ31LT/S/fw==
X-Google-Smtp-Source: APXvYqxKEeM+44Nc7BAN0DXttf0/JeAGaenDL9DVvgOTKS/vfhm8fetjaInkx0TGeZ119e12MTEjaw==
X-Received: by 2002:ac8:730c:: with SMTP id x12mr4085646qto.186.1579607134345;
        Tue, 21 Jan 2020 03:45:34 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u52sm19538008qta.23.2020.01.21.03.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 03:45:33 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: Boot warning at rcu_check_gp_start_stall()
Date:   Tue, 21 Jan 2020 06:45:32 -0500
Message-Id: <D7FEEB19-B519-4AC6-ABA4-250200E2A4E9@lca.pw>
References: <20200121050941.GO2935@paulmck-ThinkPad-P72>
Cc:     rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200121050941.GO2935@paulmck-ThinkPad-P72>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 21, 2020, at 12:09 AM, Paul E. McKenney <paulmck@kernel.org> wrote:=

>=20
> This is what you get when a grace period has been requested, but does
> not start within 21 seconds or so.  The "->state: 0x1ffff" is a new one
> on me -- that normally happens only before RCU's grace-period kthread
> has been spawned.  But by 97 seconds after boot, it should definitely
> already be up and running.
>=20
> Is the system responsive at this point?

Yes, it works fine.

>=20
> Except...  Why is it taking 96 seconds for the system to get to the point
> where it prints "Dentry cache hash table entries:"?  That happens at 0.139=

> seconds on my laptop.  And at about the same time on a much larger system.=

>=20
> I could easily imagine that all sorts of things would break when boot
> takes that long.

I suppose the kernel has CONFIG_EFI_PGT_DUMP=3Dy, so it takes a while to run=
 just before rcu_check_gp_start_stall().=
