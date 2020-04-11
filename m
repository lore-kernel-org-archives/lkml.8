Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17EEC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 16:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A049F206F7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 16:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgDKQhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 12:37:51 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:52789 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgDKQhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 12:37:50 -0400
Received: from obelix.fritz.box ([46.142.9.225]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MnItm-1ixqI53yWC-00jKfL for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020
 18:37:50 +0200
To:     linux-kernel@vger.kernel.org
From:   sixpack13 <sixpack13@online.de>
Subject: Re: [PATCH 5.6 00/38] 5.6.4-rc1 review
Message-ID: <f2f64022-0442-8773-35fc-62487580ef2f@online.de>
Date:   Sat, 11 Apr 2020 18:37:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Xzw02Ea1KBzyNgumzg3JRV5mke2Y3858+jeUn2EVaNhE5bOqNRE
 MAKCv4UX9jk/MKvncHEwAL72hFESUJxLV6q6a4G8H7/Xr7bszDQpzPkPAx2L2wjYOeHoYSt
 Q6c9gf+LDB+4r9BkR/DZpVrRlt6l8C21boXyhm006TyZTqDhjHnl76u6ghQ8N+dDXqK23rC
 a6HLud7I4Kq2lYya+QUWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fRXBL287eY0=:JE27wlm2vFADJBypCrqc51
 E7SQdXKN3SH9T5npEnBF3nKkRPq3e2r93jP5MkcbRlLuDd/05RMPUJR65+esD52VgNCnuCqv4
 0QIgBhn5dklJCbczMKWC/wfigxmPWpdv9eKDINprfvHYO7MTRbbUZU/hIiLrr0v1pNH2Ci6+W
 xjA2PhkNmOFtakfpuhOUHxZPVM9rm6wkV8H3AcTRAbdiO/12DhkUW3U+wiwk9fToTPWHiXNhB
 2oNIr5TedRDKdZBKCOTmdwaFJNcpT6FcJqiec03MMLf7akUWiWBBDZvSWQfZqSl8vfa99LqjQ
 MQ7XMXqiGctgUx3k+FObuBo7ngH0JzjOOayXJg/kCslDGNPCpiLQFQUqtYO/X3Bm6pUNAo21X
 3BZueVRZmCXlXRJKK3alkDJw/Lk7uhVkKvbDsJPdw+5tUMs/At/Yga6X8rQVYM/s4U6CIilR5
 Iv/BpVgVqyRffupgyRmf5M+4BeUQzIsnztm+w7TKy1LIiC4MvshVB65fKriKTDH5QrZMcVCUf
 /p5KrDMrT6n8IFkn6xia+SIBheb9HjA1X4yk/8UIBOEs7XnB2wzlkv21RKUTAooN7VIqxi/dh
 t+vesIKREpiEEknfg33zRFffnL2MGXb5FD/JBSJPvihje4sirT0ECBJFCBZZG63qNuEI7aIVH
 QWjN7Ha5LPMeLoonwTLVv7I13sUh7d1IOpopsI3m5SUFqT+E9zqY5g4QbFtQxEW8qmMx19BGA
 HSO60V2FVzhp3CrX32uGXQeV87yK8WiWpYkNTurqlRdmWeimnuK4SSpWJauQj1r+IuOfJox/f
 V8gJObuGCEbJ/H8lfbyRHTjYyJ2wnckMl7z/GroCDzuZVUTAHcWhRunktOq0supbbUTtHu5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo

any chances that fixes for this

https://lkml.org/lkml/2020/3/26/1133

lands into stable (too ?)

-- 
sixpack13
