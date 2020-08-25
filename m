Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E22C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 18:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33A9B2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 18:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cam.ac.uk header.i=@cam.ac.uk header.b="aVLmU1tI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgHYSSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:18:31 -0400
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:59944 "EHLO
        ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHYSS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 14:18:27 -0400
X-Greylist: delayed 1116 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Aug 2020 14:18:26 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cam.ac.uk;
         s=20180806.ppsw; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CNxKjDRYvKWGpE+XFA/hb+X/JuPege5B7rcveE/A7B0=; b=aVLmU1tIBwvQVCcV6Y60R1iNEe
        lgaEjg47uHiEMMn6vvNbP0Gomd2CzQur6WDSUrvRQpY0zDoHAGsg+b7iqq18h5Ik13JwoeXVZaeNo
        f+rRC356/OaaLNpj7uHqKxQvEWD2ShwDfDjnfPL42wXhFXsWMxfExvimVVT1zCPS4KQ0=;
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://help.uis.cam.ac.uk/email-scanner-virus
Received: from host-92-2-26-205.as43234.net ([92.2.26.205]:38104 helo=[192.168.1.219])
        by ppsw-33.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:465)
        with esmtpsa (PLAIN:amc96) (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        id 1kAdEO-000CJP-gb (Exim 4.92.3)
        (return-path <amc96@cam.ac.uk>); Tue, 25 Aug 2020 18:59:36 +0100
Subject: Re: TDX #VE in SYSCALL gap (was: [RFD] x86: Curing the exception and
 syscall trainwreck in hardware)
To:     "Luck, Tony" <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Pu Wen <puwen@hygon.cn>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Dirk Hohndel <dirkhh@vmware.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        "Mallick, Asit K" <asit.k.mallick@intel.com>,
        Gordon Tetlow <gordon@tetlows.org>,
        David Kaplan <David.Kaplan@amd.com>,
        Andrew Cooper <amc96@cam.ac.uk>
References: <875z98jkof.fsf@nanos.tec.linutronix.de>
 <3babf003-6854-e50a-34ca-c87ce4169c77@citrix.com>
 <20200825043959.GF15046@sjchrist-ice>
 <CALCETrUP1T2k3UzZMsXMfAD83xbYEG+nAv3a-LeBjNW+=ijJAg@mail.gmail.com>
 <20200825171903.GA20660@sjchrist-ice>
 <CALCETrWy2x-RByfknjjKxRbE0LBPk2Ugj1d58xYHb91ogbfnvA@mail.gmail.com>
 <dfce335fefe043868301bacf57120759@intel.com>
From:   Andrew Cooper <amc96@cam.ac.uk>
Autocrypt: addr=amc96@cam.ac.uk; keydata=
 mQINBFLhNn8BEADVhE+Hb8i0GV6mihnnr/uiQQdPF8kUoFzCOPXkf7jQ5sLYeJa0cQi6Penp
 VtiFYznTairnVsN5J+ujSTIb+OlMSJUWV4opS7WVNnxHbFTPYZVQ3erv7NKc2iVizCRZ2Kxn
 srM1oPXWRic8BIAdYOKOloF2300SL/bIpeD+x7h3w9B/qez7nOin5NzkxgFoaUeIal12pXSR
 Q354FKFoy6Vh96gc4VRqte3jw8mPuJQpfws+Pb+swvSf/i1q1+1I4jsRQQh2m6OTADHIqg2E
 ofTYAEh7R5HfPx0EXoEDMdRjOeKn8+vvkAwhviWXTHlG3R1QkbE5M/oywnZ83udJmi+lxjJ5
 YhQ5IzomvJ16H0Bq+TLyVLO/VRksp1VR9HxCzItLNCS8PdpYYz5TC204ViycobYU65WMpzWe
 LFAGn8jSS25XIpqv0Y9k87dLbctKKA14Ifw2kq5OIVu2FuX+3i446JOa2vpCI9GcjCzi3oHV
 e00bzYiHMIl0FICrNJU0Kjho8pdo0m2uxkn6SYEpogAy9pnatUlO+erL4LqFUO7GXSdBRbw5
 gNt25XTLdSFuZtMxkY3tq8MFss5QnjhehCVPEpE6y9ZjI4XB8ad1G4oBHVGK5LMsvg22PfMJ
 ISWFSHoF/B5+lHkCKWkFxZ0gZn33ju5n6/FOdEx4B8cMJt+cWwARAQABtB9BbmRyZXcgQ29v
 cGVyIDxhbWM5NkBjYW0uYWMudWs+iQI4BBMBAgAiBQJYoP3SAhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgAAKCRBlw/kGpdefoOqZEADETHadX+byfQTszP18AjvDxkiOmqKiSBv7JFeB
 +qW6Egn5mK9rggNQ4ipYm1nST14d+AKlrtCY42oifozzLnfrp2nDS9ViQU87S83QTGGH0CG2
 JtpU6IPJihxCaCyoLzMEBav16cfQRKy9KqFID1Nca5sOu4C6kiE1XriEDipEM2LmSqkSrYdP
 l85fv5WT6rIOBbxi4Gieh79exzaO8a/6yxWL6KvfTlCcMzYQbcfUqYT83mP/P6Dx+E3fkkzF
 Tb/Cgy9yuYJBAnZ2yCscvbtTILgUWFWqyJ3NNOfZ2LQU0zGvU+H7o5QsaBkNSpz3PTEEd5WB
 8I+QMhOdq6hWWU97muoeYd0dkJndKXwRTSsbly7hTxk2wj4cTGgTw/UiBlHPL26KGXSGI5XM
 Y1flNmJQBF8xy4jxkPpvaMsi5A2YU8DV0Qm9RoKYGuEKJO8zAgzJgvgVO7Kbcdv/nLLevpp0
 uPZTeWygCMr6YfBcS/r8E/qbBso7KzlxrpscCbXnJwIDmdWUvrFkP06sSsjkdS3D37yOGXkB
 DX31FdOo+vbnpoWI0meZsAGl9/wZ72GoaYxvDWcQSy85+qH4T342FRA2B6Br5/7r3D2bvlNJ
 i5DLu08dnE4KR6g3C3t1Hm0oIYJ31MtSe2RHA7ieEiJnmXsWfzAJMFPZLnVQ3yGWcontq7kC
 DQRS4TZ/ARAAkgqudHsp+hd82UVkvgnlqZjzz2vyrYfz7bkPtXaGb9H4Rfo7mQsEQavEBdWW
 jbga6eMnDqtu+FC+qeTGYebToxEyp2lKDSoAsvt8w82tIlP/EbmRbDVn7bhjBlfRcFjVYw8u
 VDPptT0TV47vpoCVkTwcyb6OltJrvg/QzV9f07DJswuda1JH3/qvYu0pvjPnYvCq4NsqY2XS
 dAJ02HrdYPFtNyPEntu1n1KK+gJrstjtw7KsZ4ygXYrsm/oCBiVW/OgUg/XIlGErkrxe4vQv
 JyVwg6YH653YTX5hLLUEL1NS4TCo47RP+wi6y+TnuAL36UtK/uFyEuPywwrDVcC4cIFhYSfs
 O0BumEI65yu7a8aHbGfq2lW251UcoU48Z27ZUUZd2Dr6O/n8poQHbaTd6bJJSjzGGHZVbRP9
 UQ3lkmkmc0+XCHmj5WhwNNYjgbbmML7y0fsJT5RgvefAIFfHBg7fTY/ikBEimoUsTEQz+N4h
 bKwo1hULfVxDJStE4sbPhjbsPCrlXf6W9CxSyQ0qmZ2bXsLQYRj2xqd1bpA+1o1j2N4/au1R
 /uSiUFjewJdT/LX1EklKDcQwpk06Af/N7VZtSfEJeRV04unbsKVXWZAkuAJyDDKN99ziC0Wz
 5kcPyVD1HNf8bgaqGDzrv3TfYjwqayRFcMf7xJaL9xXedMcAEQEAAYkCHwQYAQgACQUCUuE2
 fwIbDAAKCRBlw/kGpdefoG4XEACD1Qf/er8EA7g23HMxYWd3FXHThrVQHgiGdk5Yh632vjOm
 9L4sd/GCEACVQKjsu98e8o3ysitFlznEns5EAAXEbITrgKWXDDUWGYxdpnjj2u+GkVdsOAGk
 0kxczX6s+VRBhpbBI2PWnOsRJgU2n10PZ3mZD4Xu9kU2IXYmuW+e5KCAvTArRUdCrAtIa1k0
 1sPipPPw6dfxx2e5asy21YOytzxuWFfJTGnVxZZSCyLUO83sh6OZhJkkb9rxL9wPmpN/t2IP
 aEKoAc0FTQZS36wAMOXkBh24PQ9gaLJvfPKpNzGD8XWR5HHF0NLIJhgg4ZlEXQ2fVp3Xrtoc
 Hqhu4UZR4koCijgB8sB7Tb0GCpwK+C4UePdFLfhKyRdSXuvY3AHJd4CP4JzW0Bzq/WXY3XMO
 zUTYApGQpnUpdOmuQSfpV9MQO+/jo7r6yPbxT7CwRS5dcQPzUiuHLK9invjREdh84qycnx0/
 6dDroYhp0DFv4udxuAvt1h4wGwTPRQZerSm4xaYegEFusyhbZrI0U9tJB8WrhBLXDiYlyJT6
 zOV2yZFuW47VrLsjYnHwn27hmxTC/7tvG3euCklmkn9Sl9IAKFu29RSod5bD8kMSCYsTqtTf
 T6W4A3qHGvIDta3ptLYpIAOD2sY3GYq2nf3Bbzx81wZK14JdDDHUX2Rs6+ahAA==
Message-ID: <44754766-c996-48a3-a20e-013fa627c0a1@cam.ac.uk>
Date:   Tue, 25 Aug 2020 18:59:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <dfce335fefe043868301bacf57120759@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2020 18:35, Luck, Tony wrote:
>>> Or malicious hypervisor action, and that's a problem.
>>>
>>> Suppose the hypervisor remaps a GPA used in the SYSCALL gap (e.g. the=

>>> actual SYSCALL text or the first memory it accesses -- I don't have a=

>>> TDX spec so I don't know the details).
> Is it feasible to defend against a malicious (or buggy) hypervisor?
>
> Obviously, we can't leave holes that guests can exploit. But the hyperv=
isor
> can crash the system no matter how clever TDX is.

You have to be more specific about what you mean by "malicious" hyperviso=
r.

Nothing can protect against a hypervisor which refuses to schedule the
Trusted Domain.=C2=A0 The guest cannot protect against availability
maliciousness.=C2=A0 However, you can use market forces to fix that probl=
em.=C2=A0
(I'll take my credit card elsewhere if you don't schedule my VM, etc)

Things are more complicated when it comes to integrity or
confidentiality of the TD, but the prevailing feeling seems to be
"crashing obviously and reliably if something goes wrong is ok".

If I've read the TDX spec/whitepaper properly, the main hypervisor can
write to all the encrypted pages.=C2=A0 This will destroy data, break the=

MAC, and yields #PF inside the SEAM hypervisor, or the TD when the cache
line is next referenced.

Cunning timing on behalf of a malicious hypervisor (hitting the SYSCALL
gap) will cause the guest's #PF handler to run on a user stack, opening
a privilege escalation hole.

Whatever you might want to say about the exact integrity/confidentiality
expectations, I think "the hypervisor can open a user=3D>kernel privilege=

escalation hole inside the TD" is not what people would consider acceptab=
le.

On AMD parts, this is why the #VC handler is IST, in an attempt to at
least notice this damage and crash.=C2=A0 There is no way TDX can get awa=
y
with requiring #PF to be IST as well.

~Andrew

