Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA6FC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 22:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DAAD20728
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 22:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="X275vukm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390131AbgAPWrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 17:47:21 -0500
Received: from mout.gmx.net ([212.227.15.15]:39485 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729261AbgAPWrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 17:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579214811;
        bh=Z/+ElE6JHsBoeTs82chNmoWyjkvc9HXsuRbXbwL5AIo=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=X275vukmnCfPJ5Gm9No3n/sKhFXnPp1VhCVejl/ZHISXeXdm7WfjUzSPKYHo5rC2x
         ymQXPE+C2UPZShPUQcXq2svNTx4N7eBkt4S0o0LogYWLvbh/am6kOwWa8tA7ncwmmT
         tEjmZxbR7DTGuErp3FR4lWqXhCnza5ZKGLRami34=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.0.0.132] ([194.96.152.49]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6Db0-1iyqg734PI-006eOl; Thu, 16
 Jan 2020 23:46:51 +0100
To:     linux@roeck-us.net
Cc:     clemens@ladisch.de, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200116141800.9828-1-linux@roeck-us.net>
Subject: Re: [RFT PATCH 0/4] hwmon: k10temp driver improvements
From:   Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>
Message-ID: <576b5576-3bd5-484b-ee3f-6198f9d87db3@gmx.at>
Date:   Thu, 16 Jan 2020 23:46:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200116141800.9828-1-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Content-Language: en-US
X-Provags-ID: V03:K1:ViLtBJpUk+jRp2qBd4XUwUKlJxfM02hLwjMicorhArbxI7NXI0E
 Fym025Xo+YXV/QtkLnmnDajdIsUATHIn0b33esuq7F3iTGVoAKWYnNfIlU0kR6ApV3NKw8/
 dDFS26mCJYQZwA5eRQDv0IJTOuzBx9bbRScU0Pqtga2idz9PkQczxp8WvCDa2aBr/dOCbUx
 TBWMDr9MfBi9EgmG7OiXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mbx1B16A6HQ=:AZAVkGej55w2Ul46MqypZn
 mfsVLPlaq2SU6bEbkCHYFS6YBqTdN+d1CzVWCPAOI2kCjPvKG1tYvtQqCe9rubTAhce95ZTAX
 f3e1lvmJC4tJBT1PzXzbzoFuNioR8A4VxNEihVdV5n5Y55o8upOjUrO//tPbmXfm8w5XbeFiX
 ee9z3xjTnrSrAcY5WaA1ohc9fHauC3FHvX2A7vWtuRjP5n6Iej0DyzwDWrm1ECb0Amn/WpE3L
 U6m8ajlq4KVtKdbz/lC7ZoTU0Ak+B1kKRNiY6w9QxZJxltSyIbU/5uqZqeLeVCyGea/wgxbgP
 ZohQUpIjo+fI0AuFH8rZLAIKUOS/HohzWK84+9ZQ6uX6EGuy1+Q0TMp3ghQCyM2E8145XC7J7
 ycms2G0QPPZsTqJRK78bw+fHxFKxxXTHlJmUekg8soctkEy2YF8xS4U91C8dk/qiqhL9RX+DS
 kfu0ZOz2mtPm0Y8NBpxjzV7N385YVeGb/NiUhutqVdVEZUva2ejjOxTclCw5R22MN3t+5xClE
 nOU6VzEPoY24rA5TdeQOzjlNM3/hH9R/2yKkwaW97t1O57EpRkd6EcApoy4jW+MX1oL0SV5z/
 CmOyCxy8xMJu50MrdFTW5ZjDXExjBC5DebmqxC3Ao2YEk8JA/tSdo+e/+VJG8b+jA5PQlU5nb
 zcJOOa4ueNJXRxBVwffHzMJfklzZNFLPQEHTN1wINt0nmaZ1XNiJ0H9qRKEVkCVh0rQMRYfla
 WsV94ZUUbMOrSotgvsL66t1ZM91GIMltV19lZ4Eezxn0wAtnZEEoIR37NLXM8v7WJV6oYAt7d
 3Bl9A4Rw2WE+HNdw4JFZU6jppp19VtAS+FBuMj0UpMO8MHynkKsf4q5YZaagm2AYxYhjt3aIN
 VewJ2TiyiLru2Vy0agzB416fnxEj4NI867WSK1PJ5TSV3/vqiQ8amO32OlDDLRz76rDyjw24/
 Ph6NNogqFcbeCbPliCfvsWkdA7Vnc06HEyYFrr0clik64Lsse3RC446vdkobeZ2XP7a43+xK7
 cHtFo8E8Dqau1kHLXGgZy9bt/riTfyk1VdU5oySc0GiZkEfVQTXmkxB3IcEwT6KS/cLBb58AM
 ciE5oa/3P/OLA6hZ3QRbs4zAhMmmymKbFi8iXs7WprTA4szMtJ2JT/ouloohWS8DHzOSsLRs8
 7hGFv/ohPsYeJ/QYTIwIkBIq3l4154bJhpQ0v92YFi5ZwnpNVwh9ytDm/AYaBQ6Q6dk6nFxo+
 IfSyEd96eMeJOK3ZYkqvMyCvFdPgsXF+BiVIDWWBPT0zn8jQWCmFklK/fAH8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGVzdGVkLWJ5OiBCZXJuaGFyZCBHZWJldHNiZXJnZXIgPGJlcm5oYXJkLmdlYmV0c2JlcmdlckBn
bXguYXQ+DQoNClBhdGNoZXMgYXBwbGllZCBjbGVhbmx5IG9uIHRvcCBvZiA1LjUtcmM2LCBubyBp
c3N1ZXMgdXNpbmcgYSBSeXplbiAzIDIyMDBHOg0KazEwdGVtcC1wY2ktMDBjMw0KQWRhcHRlcjog
UENJIGFkYXB0ZXINClZjb3JlOsKgwqDCoMKgwqDCoMKgwqAgMS4yOSBWwqANClZzb2M6wqDCoMKg
wqDCoMKgwqDCoMKgIDEuMTIgVsKgDQpUZGllOsKgwqDCoMKgwqDCoMKgwqAgKzI4LjLCsEPCoCAo
aGlnaCA9ICs3MC4wwrBDKQ0KVGN0bDrCoMKgwqDCoMKgwqDCoMKgICsyOC4ywrBDwqANCkljb3Jl
OsKgwqDCoMKgwqDCoMKgIDIzLjkwIEHCoA0KSXNvYzrCoMKgwqDCoMKgwqDCoMKgwqAgNi40OSBB
DQoNCi0gQmVybmhhcmQNCg==
