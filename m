Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A766C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63581206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="N9a66nde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgFAPdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:33:43 -0400
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21119 "EHLO
        sender4-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgFAPdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:33:42 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591025580; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=GHRBeZnlWZnIYPTLg3zRKDx0QSc65rXEjGHJocN6TBfOJ+rIQBOe86hanm+YlncMZCs87BSjJUe/XZWw83OS8Af2Q+c9gQ3yEmZjuuwkrnylQm+Vib3qvaKjVcAWv7uwVYc4VzlQemLbmYQYCMC4I4JsgpN1fPvFLS9F7ZyNIpk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1591025580; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=M9wcsyYgkGeYgK964bpMd3S8333YTO6TNJb+OFD5awM=; 
        b=FkmFQiEUAPl2S3Gi/LoCwVZUpDi+bDhxxjOMDAe9hK8mv085zCoB3FQXPO/M7V487wlECKdTRUZT2251J5CDewOe2srN0xqHSHsTeMkx+wt+mnzvmbcC1cyXyzEu9Do7gdRbVxZa+ph/BXgmLLP8L/YhiNJxgLpVo7PizwE67FE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com> header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1591025580;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=M9wcsyYgkGeYgK964bpMd3S8333YTO6TNJb+OFD5awM=;
        b=N9a66ndeHfgUcbs6WCRaY63hH6/tahPxAyzJlmxZO/lm0jZmmccu7kDWgDNeGYOS
        Zb1X4G8HucjzOO/C+3/fPxSd0wIExz+b8ucYMLn7ByFZVsSUJaax034XzyyG/+bFrYq
        gR+00Ifb8nXoye7SmFFFH1Wq5pO3/i+TPDC3C1ro=
Received: from [10.10.1.24] (c-73-129-47-101.hsd1.md.comcast.net [73.129.47.101]) by mx.zohomail.com
        with SMTPS id 1591025577379467.5063829504761; Mon, 1 Jun 2020 08:32:57 -0700 (PDT)
Subject: Re: [GRUB PATCH RFC 00/18] i386: Intel TXT secure launcher
To:     Daniel Kiper <daniel.kiper@oracle.com>,
        Lukasz Hawrylko <lukasz.hawrylko@linux.intel.com>
Cc:     grub-devel@gnu.org, linux-kernel@vger.kernel.org,
        trenchboot-devel@googlegroups.com, x86@kernel.org,
        alexander.burmashev@oracle.com, andrew.cooper3@citrix.com,
        ard.biesheuvel@linaro.org, eric.snowberg@oracle.com,
        javierm@redhat.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, krystian.hebel@3mdeb.com,
        michal.zygowski@3mdeb.com, mjg59@google.com, phcoder@gmail.com,
        piotr.krol@3mdeb.com, pjones@redhat.com, ross.philipson@oracle.com
References: <20200504232132.23570-1-daniel.kiper@oracle.com>
 <2dad6366d2fceb0a9e36f284a8ed5a8ed86d8756.camel@linux.intel.com>
 <20200507110634.2yvzirauq5md7d2q@tomti.i.net-space.pl>
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
Message-ID: <d1b55f25-e54c-b259-8836-d834a572de3b@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; prefer-encrypt=mutual; keydata=
 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
Date:   Mon, 1 Jun 2020 11:32:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200507110634.2yvzirauq5md7d2q@tomti.i.net-space.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/20 7:06 AM, Daniel Kiper wrote:
> Hi =C5=81ukasz,
>=20
> On Tue, May 05, 2020 at 04:38:02PM +0200, Lukasz Hawrylko wrote:
>> On Tue, 2020-05-05 at 01:21 +0200, Daniel Kiper wrote:

...

>> In OS-MLE table there is a buffer for TPM event log, however I see that
>> you are not using it, but instead allocate space somewhere in the
>=20
> I think that this part requires more discussion. In my opinion we should
> have this region dynamically allocated because it gives us more flexibili=
ty.
> Of course there is a question about the size of this buffer too. I am
> not sure about that because I have not checked yet how many log entries
> are created by the SINIT ACM. Though probably it should not be large...
>=20
>> memory. I am just wondering if, from security perspective, it will be
>> better to use memory from TXT heap for event log, like we do in TBOOT.
>=20
> Appendix F, TPM Event Log, has following sentence: There are no
> requirements for event log to be in DMA protected memory =E2=80=93 SINIT =
will
> not enforce it.
>=20
> I was thinking about it and it seems to me that the TPM event log does
> not require any special protections. Any changes in it can be quickly
> detected by comparing hashes with the TPM PCRs. Does not it?
>=20

I think it would be beneficial to consider the following in deciding
where the log is placed. There are two areas of attack/manipulation that
need to be considered. The first area is the log contents itself, which
as Daniel has pointed out, the log contents do not really need to be
protected from tampering as that would/should be detected during
verification by the attestor. The second area that we need to consider
is the log descriptors themselves. If these are in an area that can be
manipulated, it is an opportunity for an attacker to attempt to
influence the ACM's execution. For a little perspective, the ACM
executes from CRAM to take the most possible precaution to ensure that
it cannot be tampered with during execution. This is very important
since it runs a CPU mode (ACM Mode) that I would consider to be higher
(or lower depending on how you view it) than SMM. As a result, the txt
heap is also included in what is mapped into CRAM. If the event log is
place in the heap, this ensures that the ACM is not using memory outside
of CRAM during execution. Now as Daniel has pointed out, the down side
to this is that it greatly restricts the log size and can only be
managed by a combination of limiting the number of events and
restricting what content is carried in the event data field.

With everything that has been said, I am wondering if it would it be
possible to make it configurable. Thoughts?

V/r,
DPS

