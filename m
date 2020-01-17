Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA98C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BDA21D56
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="RlgORZ/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgAQQfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 11:35:11 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]:45047 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgAQQfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:35:10 -0500
Received: by mail-qk1-f172.google.com with SMTP id w127so23207975qkb.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 08:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=6is2X1qi44pt2A21wyyQUE+/mtVgsMKumSiZBpCadjg=;
        b=RlgORZ/52mc53Fi3iu3/51jHSqQavtqJRjFUaNi7KAE7AlCO33wDsNSiwwuX9bajJf
         FdnhQKnrkLaO9YV1TyULB2lVpkzPzL7+dIQT4jRRaVovvpaYxbz+V36VYUw3G9gohUZ1
         EZfeZMK9TiBFW3VH3TZ8YRwYaw6RH/HPjbOD4lxEgDNyDpnEiElXl9w+KJUa5N3QYex7
         RTuwB/b8/OqY8HFsMIhl7HKfqo8u99RBga10o8zq+bs009nEogmQLVojv0fiR+sUtdJk
         GbJnm4LGyfSUE4Fwx8lscBbAGVGkAnoH/tGVGr02WM2/wodf+GWxT+3wxGvrsdFshFBD
         b2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=6is2X1qi44pt2A21wyyQUE+/mtVgsMKumSiZBpCadjg=;
        b=OZpZhlIXfT1rZ3OW0fEm5IXbMrTHDTysP7gGLjbfdo5NkyFF6dfFo9f2J0hIjsWDTj
         6tTGpFzucWkgPtDb1WZvxeDxOWg1YB6O3IFOd09vsDlI8cw0EL1Wf7dwaGCzjPyxWBm/
         30HbDeZ6n69KrG9BDsuC8h+ms3sA6cM/377UjyghcBlykzp/a4ndvuQjRJI3AhT0a3bA
         RcVCBlQYvxt4gB/o7Sjqy5inMmlk6yy21InzWGFK+yHAxVbbMY3XMNxTRd+9B+yNaLAY
         oX4SYNAy6x/px/5VilTNkJIrvTswHJDDCjsM8KEsYP5GiT04KRMnUJJqsEVK98H54Aus
         LGEA==
X-Gm-Message-State: APjAAAUQXW2Kg18GeQFNmNd5NfdfFBNypDPrOXbj8JqY7+MERWSVfWDH
        lYntPuNqtus2w9MuqNl3s85+nyDwOVSmHA==
X-Google-Smtp-Source: APXvYqxDb/sO1cYBfC7DsyWAAQ6RZwErytR69D9BO+T0QX2aj7jbDdu72BCJ4rKg7CSRJe1SoYEnnA==
X-Received: by 2002:a37:9f57:: with SMTP id i84mr39281060qke.29.1579278909437;
        Fri, 17 Jan 2020 08:35:09 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id r28sm13557339qtr.3.2020.01.17.08.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 08:35:08 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next v5] mm/hotplug: silence a lockdep splat with printk()
Date:   Fri, 17 Jan 2020 11:35:08 -0500
Message-Id: <587CD165-FAA4-4369-9F30-CB8F9C03F062@lca.pw>
References: <5abf5440-7c1c-b9e9-9770-b89759771a44@redhat.com>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org,
        sergey.senozhatsky.work@gmail.com, pmladek@suse.com,
        rostedt@goodmis.org, peterz@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <5abf5440-7c1c-b9e9-9770-b89759771a44@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 17, 2020, at 11:27 AM, David Hildenbrand <david@redhat.com> wrote:
>=20
> the "int" should go onto the next line as well
> [...]

Yes.

> apart from that looks good to me. I hope we won't have a whac-a-mole
> with printk() (including WARN_ON() etc?) under the zone lock. This all
> screams for a better fix.

WARN_ON() is normally not a concern. Once it happens here, we will figure ou=
t the reason why it happens in the first place and shut it off there instead=
.=
