Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF6EC2BA80
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 11:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE22E20780
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 11:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="EVHI8E2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgDFLul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 07:50:41 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:39195 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbgDFLuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 07:50:40 -0400
Received: by mail-pg1-f180.google.com with SMTP id g32so7428360pgb.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 04:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eSEYeGHJW6L1yFZdjvZu8BXqsVS6+Imz64kPAhoNehc=;
        b=EVHI8E2HsQJ9Svnqp+R7hSaCboaInyxUjdHuKNMRYaAqw5fsam3DG39gWQgpdFNaBM
         IVZBl4jvVImZHpXf7WHBYPhkPNwaUgr3HWmQ7eyVptt+1tQcAbJNGqeCbUc9L/iFPukC
         jH7zHJWalVPlP6OcmvBNWSpflfGaooqDmqL4UcteTQg+StXxC07N+g+ZdLOArukrSS+2
         KP82QOWORNZ4eCLxuXVU1rfbBbXUNQLQDarzkT39jLEPXSu+hmCYJyKGgkJDA+444lJK
         D+IrrKM38coX84i+GYBhQmjcb2yR4BWeOGdv/0sUCIcDZXPty+OIuQHyCYyDDAYbkhuw
         d7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eSEYeGHJW6L1yFZdjvZu8BXqsVS6+Imz64kPAhoNehc=;
        b=JXP53vtHHecf+ItntAAzKaVNfes9OzjWce/hOJBDXgLgdYOg5kZ8g/KHPkJBwkSyBg
         4jWXQR8Z2c1Ahyt3TNlN1DJPf81U1VyAdOc7Y2JkfXfAa8TWNbQBP3ipn1wpGzhjEPqO
         j+wqJm54uldz2SEa+VlPOnqpQE2fPQCjvL2PZJeVQ9k8vonVnIDSIVW09jAv0CS2OI0v
         MYDOhqU4GpiQmjHFQRrwZJCgDRUpdr+ddSCz9VTiPzHhR9xzgHSDzX5DcijglZ1GrqIT
         xc7RJJrr3aA7OzxrXAj2o6Kf3HwQE+ZE7JxXaQAnUzp2QwK9N5xrw+QXfs/MCVYNHibc
         fmcw==
X-Gm-Message-State: AGi0PuZoKWd/OJ5HRwArrFnETT4NNZdN0MmoK0ZhljD8H4H21t5lTOQX
        IzX7eBLMFOFk4Y44GJ+IRjHYIw==
X-Google-Smtp-Source: APiQypJbSk9nhcIBkVtji01qlTReiqSK+1z9CtKxnbEsDtTA6Mr0Dhzwjf+aZwsQgRIaFpUTWaZjSQ==
X-Received: by 2002:a63:6346:: with SMTP id x67mr20405820pgb.67.1586173839100;
        Mon, 06 Apr 2020 04:50:39 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id k6sm12024505pje.8.2020.04.06.04.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 04:50:38 -0700 (PDT)
Subject: Re: RFC: time_namespaces(7) manual page
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Andrei Vagin <avagin@openvz.org>
Cc:     Christian Brauner <christian@brauner.io>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Containers <containers@lists.linux-foundation.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Adrian Reber <adrian@lisas.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
References: <7221df0a-435b-f8bc-ff91-c188af535e73@gmail.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <a74763df-6523-2103-b687-27cae3a433fc@arista.com>
Date:   Mon, 6 Apr 2020 12:50:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <7221df0a-435b-f8bc-ff91-c188af535e73@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On 4/4/20 12:08 PM, Michael Kerrisk (man-pages) wrote:
> Hello Dmitry, Andrei, et al.
> 
> I have written a manual page to document time namespaces.
> Could you please take a look and let me know of any
> corrections, improvements, etc.

Thanks a lot for the man page. It looks good to me.
Maybe Andrei will find some nits, but I don't have any in mind.

Thanks for you work,
          Dima
