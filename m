Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3631CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 091BE206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=vt-edu.20150623.gappssmtp.com header.i=@vt-edu.20150623.gappssmtp.com header.b="Nj3F3BC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgHSHeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 03:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbgHSHeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:34:10 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C33C061389
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 00:34:07 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 2so20748141qkf.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 00:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:in-reply-to:references:mime-version
         :content-transfer-encoding:date:message-id;
        bh=4V25VWVtltBCvoDctm/BLfmJBIJ+HmrsOxjPE64+VqQ=;
        b=Nj3F3BC3xyKczep856g1h9CyMlJDYCs1YJNuTqR93+L98c+Pa9l7wcyG/eLo0gHbwy
         GnGY9yFORoqKHgnC/mu8CxZj9Rs4s8QgsK0TIsEXCPbHpgmef+SxfDlUiZ8c77PqEl7G
         1E5AfbjXwonMZHl4bSlJbHgpP6FzS8o1Cx5vOGs3zTY3WiLJQAEmgBdyaY2Zs31E7J/d
         xYQNGG54DlMxpDDvQ9LN4nj4yHXreqYhYFEGXPidHmixmJs9TWE7yMUYp0o9m5rKsadp
         jWfFtbcJmuiRlhclWFcTOfSHWxhWKQe9Nz3OryDsvTHHEQmvNs0tvJ22TOkM68+k1OW4
         GvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=4V25VWVtltBCvoDctm/BLfmJBIJ+HmrsOxjPE64+VqQ=;
        b=mGEVxeLx7fuX1BwYW1vopzsBdcuwxg5Jyfh7j+FhIX8S47esiVDYD4W7QerEayJXdm
         eBOjTtE7YPoDoUBmfeIy4WHqusWxOJbif3TPIMRKwt6K9BOIUuYlbf6B3YyRXwMcwLSN
         Y3O927rKnf7RzeMWF7c6Xt8D+qpmaZf7P2bqWOssOSVIi/OUFnSSrWItTto/TyvJ3UxU
         Janrl0R6n+DALjvYQcvfUVPkUy0SBKjWeixA3qgvrjWPL7XNQRLI8hJfmevCynlOBnNS
         k9n/4SYbuzCJHi4DzNE1sECqbRdVnP711RibwpdaIY5Ugg+VVvpWTeZLu5Ao8EDGXoj4
         gkvQ==
X-Gm-Message-State: AOAM530NgU08ttMtQHzl0GPyyDDEkfg4P/GBkhWxcVQjnxSe21haAAzm
        ksXLu8EzoAP3udQCtPzfMWr7mA==
X-Google-Smtp-Source: ABdhPJzxxwMT0A58bbawoYx+tooriUG/ayuWsBOo+fDqxMvTWjyv5RQiVULyZeNBeYSVgyFfcy0M6A==
X-Received: by 2002:a37:47cc:: with SMTP id u195mr20561392qka.39.1597822446957;
        Wed, 19 Aug 2020 00:34:06 -0700 (PDT)
Received: from turing-police ([2601:5c0:c000:a8c1::359])
        by smtp.gmail.com with ESMTPSA id 20sm26987224qtp.53.2020.08.19.00.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 00:34:05 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Mark Starovoytov <mstarovoitov@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, paulmck@kernel.org,
        peterz@infradead.org, rostedt@goodmis.org, tglx@linutronix.de,
        will@kernel.org
Subject: Re: [PATCH] Revert "seqlock: lockdep assert non-preemptibility on seqcount_t write"
In-Reply-To: <20200819070022.semyxepadnvtmtcr@linutronix.de>
References: <20200810085954.GA1591892@kroah.com> <20200810095428.2602276-1-a.darwish@linutronix.de> <20200810100502.GA2406768@kroah.com> <bcf94ea2-05e6-2212-f732-b9a79a142f7e@roeck-us.net> <169454.1597791078@turing-police> <fa442483-00b5-169e-dac2-71fbf8307117@roeck-us.net>
 <20200819070022.semyxepadnvtmtcr@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1597822443_10889P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Wed, 19 Aug 2020 03:34:03 -0400
Message-ID: <15863.1597822443@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1597822443_10889P
Content-Type: text/plain; charset=us-ascii

On Wed, 19 Aug 2020 09:00:22 +0200, Sebastian Andrzej Siewior said:
> On 2020-08-18 17:56:49 [-0700], Guenter Roeck wrote:
> > Nice catch. FWIW, there is no obvious reason why this would need to be atomic.
> > The calling code does not set a lock, meaning there can be two (or more)
> > callers entering this code. Weird, especially since the code looks like it
> > would actually need a mutex to work correctly. It might be interesting to
> > see what happens if there are, say, half a dozen scripts/processes trying
> > to read the hwmon attribute introduced by this patch at the same time.
>
> => https://lkml.kernel.org/r/20200818161439.3dkf6jzp3vuwmvvh@linutronix.de

Looks reasonable to me, though I've not verified that it's preemptible at that
point...

--==_Exmh_1597822443_10889P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXzzV6gdmEQWDXROgAQLTbhAAsvypcbMHOpJZyQfamYXGuY2lN7OfIdhc
S5HWEeQpsT/KLRmXDTl65fpNYUcUkrtp7n56JYmIG7O5PHPx9fna2x2X/adqvE02
FrNmboXuo4s0ajokOsA7N8Fgeebjz6+sfr4QNVnatPx71vaPUvZXVXuI1HLhw51M
yq6r0eMBNl3JwqXLDcKVcsoAHqjK3WgbUNZnH+aOYUsgnoUb9YfgLLOFXWASd3bd
F9griIUcY+Vp5M0z0TUmHR75BDriocvB/0ztg/ePKpuiaZVP7IOYskXYz+KZi6q4
D+KojbYx9xIOWVFW7Op6q2j7Qq6P+9VRpjU7L9qwhKHyQ1fFcEgvrzcI4Wa3LUhN
JvcPIo1N1W5FRWl19YBn6w9cLLcSoh4dmoKOeyNFgUP4moR6JqeSoH5hT32vY7js
5IC1DxQ3PLsHSaqbPoTvBoabLvS8q/wcldxt21sZMSQF3Yj68CSQBqCM0ZJxiZEO
Dy1POgrNg0rDUfJoEg5utx7Raai8VsUeZbfVc4ZxGdKRKc9mHmShNKzv0zLEcbmo
u2e260jtzLr+cV+UaNek4IA2yUw9WvtopsXyYI3tt3octGGgEPjifYALxtJRwg6t
DBx6N5tKLO6ROt2so5zSkssWzl9jjHuZ8NbID/dIp85gv7r8dK+49tB+NHU5sOcb
CN2QI2uwknQ=
=pX+Q
-----END PGP SIGNATURE-----

--==_Exmh_1597822443_10889P--
