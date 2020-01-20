Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A847C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B9221D7E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgATQUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 11:20:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:42376 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729045AbgATQUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:20:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1715BAE8C;
        Mon, 20 Jan 2020 16:20:49 +0000 (UTC)
Subject: Re: reiserfs broke between 4.9.205 and 4.9.208
To:     Byron Stanoszek <gandalf@winds.org>
Cc:     linux-kernel@vger.kernel.org
References: <alpine.LNX.2.21.1.2001200956220.14639@winds.org>
From:   Jeff Mahoney <jeffm@suse.com>
Organization: SUSE Labs Data & Performance
Message-ID: <4c36762f-1fa7-01a9-868c-e3deeaa10fa3@suse.com>
Date:   Mon, 20 Jan 2020 11:20:46 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1.2001200956220.14639@winds.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sjPuTMLKU0tHcirru48NnQUFQPTOfw74D"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sjPuTMLKU0tHcirru48NnQUFQPTOfw74D
Content-Type: multipart/mixed; boundary="aufVKgB8PG1Tl2Jo6yNwUHtkIQyE9MSAI"

--aufVKgB8PG1Tl2Jo6yNwUHtkIQyE9MSAI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/20/20 10:03 AM, Byron Stanoszek wrote:
> On Wed, 15 Jan 2020, Jeff Mahoney wrote:
>> On 1/9/20 7:12 AM, Jan Kara wrote:
>>>
>>> Hello,
>>>
>>> On Wed 08-01-20 15:42:58, Randy Dunlap wrote:
>>>> On 1/8/20 11:36 AM, Michael Brunnbauer wrote:
>>>>> after upgrading from 4.9.205 to 4.9.208, I get errors on two differ=
ent
>>>>> reiserfs filesystems when doing cp -a (the chown part seems to
>>>>> fail) and
>>>>> on other occasions:
>>>>>
>>>>> =C2=A0kernel: REISERFS warning (device sda1): jdm-20004
>>>>> reiserfs_delete_xattrs: Couldn't delete all xattrs (-95)
>>>>>
>>>>> =C2=A0kernel: REISERFS warning (device sdc1): jdm-20004
>>>>> reiserfs_delete_xattrs: Couldn't delete all xattrs (-95)
>>>>>
>>>>> This behaviour disappeared after a downgrade to 4.9.205.
>>>>>
>>>>> I understand there have been changes to the file system code but
>>>>> I'm not
>>>>> sure they affect reiserfs, e.g.
>>>>>
>>>>> =C2=A0https://bugzilla.kernel.org/show_bug.cgi?id=3D205433
>>>>>
>>>>> Any Idea?
>>>>>
>>>>> Regards,
>>>>>
>>>>> Michael Brunnbauer
>>>>>
>>>>
>>>> Looks to me like 4.9.207 contains reiserfs changes.
>>>>
>>>> Adding CC's.
>>>
>>> Looks like a regression from commit 60e4cf67a582 "reiserfs: fix exten=
ded
>>> attributes on the root directory". We are getting -EOPNOTSUPP from
>>> reiserfs_for_each_xattr() likely originally from open_xa_root().
>>> Previously
>>> we were returning -ENODATA from there which error
>>> reiserfs_for_each_xattr()
>>> converted to 0. I don't understand reiserfs xattrs enough to quickly
>>> tell
>>> what should actually be happening after the Jeff's change - naively I=
'd
>>> think we should just silence the bogus warning in case of EOPNOTSUPP.=

>>> Jeff,
>>> can you have a look?
>>>
>>> Also Michael, I'd like to clarify: Does 'cp -a' return any error or
>>> is it
>>> just that the kernel is spewing these annoying warnings?=C2=A0 Becaus=
e
>>> from the
>>> code reading I'd think that it is only the kernel spewing errors but
>>> userspace should be fine...
>>
>> This error occurs when extended attributes are not enabled on the file=

>> system *and* the module is not built with extended attributes enabled.=

>> I've sent out the fix for it just now.
>>
>> -Jeff
>=20
> Hi Jeff,
>=20
> Can you share the patch with us for testing? I haven't seen this hit
> mainline
> yet.

Sure.  I posted it to the reiserfs-devel list last week and Jan Kara
pulled it into his tree for submission to mainline.

It's in linux-next:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commi=
t/fs/reiserfs?id=3D394440d469413fa9b74f88a11f144d76017221f2

-Jeff

--=20
Jeff Mahoney
Director, SUSE Labs Data & Performance


--aufVKgB8PG1Tl2Jo6yNwUHtkIQyE9MSAI--

--sjPuTMLKU0tHcirru48NnQUFQPTOfw74D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE8wzgbmZ74SnKPwtDHntLYyF55bIFAl4l014ACgkQHntLYyF5
5bIKCA//WBZlPdTHYsb2KLyzY4HrXWgaghkoPvK9oglsEL5DjxGBAKEBLKSnRvkh
6Yx1Lcr2Wt8KbFTMF5KvOTUayd893xMNmPKHE91FZnJlq1rnvhjG7zZ/mdq8JwD6
EKLmVTMibsvVuZF0P9Z5qTU/3u1CijKCUnTrKcuB8IrQxjooQlRMYX3Av+fcljy7
Ciy5gri7zT3WQ2pr9ZezbNzB95T0RDfGRs4R7Zh8v+lmV9HrpivW1yWdX+0xEd++
Wj3eUBeED+Ctfr7iCK8HaG7nY7ymwbrRSQF0WCAvi/gcBy764HGaIB4ZrSuEfvfC
DfGFtJy4VAzpmeU25fDkePJD2HKBp0bWVoeTe8avO4ciuInqnad9A9Oi9JAQp7+U
nzsfGyJxKhpz0sNMIz4zKfcNfz9m0UiKBxyN6kldhyhKj1gHFMb6pVavGE//l/+C
JOK2+qDAN8uhNx/76Xk46ZcArzJXmPryPKT5y/FvUHTwErhuXfPUENU5ZxFyFvpq
TULNtGT0d1djr6b1+OX6l3veW5uz+mIJisI/WwxQLSRGN+0UfxkkPP/YZDj2+Sfc
MzWd+1U/0d16C5Yvz1xE2Lm3wjssojtB6TJ6rVn/XdmeEHz7Igd022F38x2O/4Iu
d/Cw6VkFCt8qT+uW7+eB7GqCdNC7tnutRJbqMs0I/OOXAaTNyEQ=
=vhfi
-----END PGP SIGNATURE-----

--sjPuTMLKU0tHcirru48NnQUFQPTOfw74D--
