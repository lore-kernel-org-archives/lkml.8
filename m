Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0950C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A101C21835
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgAWN1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 08:27:47 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:60309 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgAWN1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 08:27:47 -0500
Received: from [192.168.1.155] ([95.114.14.250]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Md6hP-1jTxC73TD1-00aHr1; Thu, 23 Jan 2020 14:22:40 +0100
Subject: Kernel folks @EW2020 [Was: Leads On Embedded World 2020]
To:     Mary Smith <mary.smith@oceanedata.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <!&!AAAAAAAAAAAYAAAAAAAAAPfxu8Y9lMVAhLaSR/F6sVHCgAAAEAAAAKuY8NYSOGRDkEGiewT8y/EBAAAAAA==@oceanedata.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <928a3549-61f8-9c6c-d7d5-ea54263663fc@metux.net>
Date:   Thu, 23 Jan 2020 14:22:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAAPfxu8Y9lMVAhLaSR/F6sVHCgAAAEAAAAKuY8NYSOGRDkEGiewT8y/EBAAAAAA==@oceanedata.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:wh0ZPFj8PXe0ug5WwQNbu1yAKL3UUceQkvXqzmRVyligswlmjYB
 0shGNuRgrOOgG9RbqbtiMk48W24qLDllEp3rEr4GPJBDUxmV/8MBaiq6/EfUuqCICcXGNkH
 qEQGuMBCQEvRsY9e1EZpkEXMogqKfhwGgFdUDax0YnEWSJWlXEBQpicJq3O9MvmUMAMdu9V
 vEcylLhrQzxf+iFR6sKkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jmBLpeyhTOE=:yk4zA0lKGxYMjUhXhrX7KA
 rkXy51SjxLtbLtYII6cIsdpmbuzg0Jb3cj1FOx0gIgA8wWv0DEJrFmN38WlyyPJG5S9H9VMBG
 qp9D55zWe1Qrj+E3QwSm5vH8pLn92/5e91dpigEv73vAO0N7IGgBxgi/suD7y/hHpuc1tBMXK
 zKePb6CMDX20D+QBsn1yQVI+0HvxneZPK5Tx3MCWCb9VmM2bjAiLzm+herXaz/6ro/qeQx9jl
 f6NW/m0zC+e88jNhqQQx9iae6fNkl9nsNNgnG9+1wXKvHCfMZBho9Ps6kzKTLssB94RDqpbyK
 rIA0jwf+8NGVl0E+SS5/j8oA1pChoo3MHqfJ+Oi64VYYgarzc/vU0c7iXKsue2xYYYjmUCsuG
 g40FFlE6rBH6kcC1DvC+h7IV5PKQDEO+sOroFGRQW/xV8gqSVrDKpeWYbgzzU+Z+ch/NP5Ceo
 wXOj4kN6P6hBojIpS+IYctyKF09rwajMSNlSJ9slYODEzbm6908i9OvEXDnEmjZSOjs7rZW/K
 u/2wHVfSFtVeAW0Od3PczXj4pTPN9ikJ+WhE4aWKGL0ZM1yurQ9jcniIAc4ejNkO1xC8Gu8rC
 GnVD2S9qQwLbzxViULdngrMLE582nJtD121noHmLHJ7+pfGEmupHditiJqfkb51fwD6K6maOo
 rfnZRmfQbbXdzTBKkBTw3m/kWqgCzOMgn3pxMP7MDMpeEizpDalDUYdgNH9q7hvOMHWNFTT1N
 +MorHUWRQ7xEpqWh9qATvAgpkOUgXT0Dh6RyVAosDNqTgQKo1sqtuFYJ3/RwXhRKqU6Y4xOEL
 aOefnUT0jL1UUepCkId+TUvntUP3ZryKPt9iXvyxQggTMag5MO6XHQe6Cjlnx7Yt+zheWBG
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.01.20 07:30, Mary Smith wrote:

Hi,

> I wanted to reach out you if there is any need of Email list of Embedded
> World 2020 Attendees?

I'd be more interested in who of you folks here will be there.

Let's have beer/coffe together there :)


--mtx

---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
