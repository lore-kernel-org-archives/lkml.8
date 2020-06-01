Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50994C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 251BF2074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J77mYik0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbgFASF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:05:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55478 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729647AbgFASFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:05:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 051I2uwT109010;
        Mon, 1 Jun 2020 18:05:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=oXuXgSbylTNkBB9TLIpKF4Z5sJfn3YpH5Bn3XIrCw4k=;
 b=J77mYik0FHXBLepXsAIKycT6y/3UOFDIr5tQbmKJj8CW8wYC9i9GlYI8UFoiT+44+vBU
 Atv66vyJ+d422F/xHv+3HVU5vyxkXqbvgYNoq6StjHzs8bhQbA0sRs/wL2HYBaSuwUhW
 uPtJ2r9Lsu0IuZ9d9oW6wfN77pL9b4pxK9Ih3ZOFBHeCslzq2UVFvaXxiBYz6Eu3Dz2f
 bGa9FW47q6JHagwb2suNO87bLXK/39lhUy9rXXgrXNwgT6T241SCb0n0D5qJlPVZ5wmU
 1R+tJXJOvRc3i+mCLr5veoAnTKIeb48imVr0iL3EAJg4JHJVJMs+zcKb+BNMC1OhR4LB 6g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 31bfem02b2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 01 Jun 2020 18:05:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 051HrrUM135279;
        Mon, 1 Jun 2020 18:03:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 31c25kc588-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jun 2020 18:03:06 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 051I33aL012865;
        Mon, 1 Jun 2020 18:03:03 GMT
Received: from [10.39.241.107] (/10.39.241.107)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jun 2020 11:03:03 -0700
Subject: Re: [GRUB PATCH RFC 00/18] i386: Intel TXT secure launcher
To:     "Daniel P. Smith" <dpsmith@apertussolutions.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Daniel Kiper <daniel.kiper@oracle.com>,
        Lukasz Hawrylko <lukasz.hawrylko@linux.intel.com>,
        grub-devel@gnu.org, LKML <linux-kernel@vger.kernel.org>,
        trenchboot-devel@googlegroups.com, X86 ML <x86@kernel.org>,
        alexander.burmashev@oracle.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        eric.snowberg@oracle.com, javierm@redhat.com,
        kanth.ghatraju@oracle.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        krystian.hebel@3mdeb.com, michal.zygowski@3mdeb.com,
        Matthew Garrett <mjg59@google.com>, phcoder@gmail.com,
        piotr.krol@3mdeb.com, Peter Jones <pjones@redhat.com>
References: <20200504232132.23570-1-daniel.kiper@oracle.com>
 <2dad6366d2fceb0a9e36f284a8ed5a8ed86d8756.camel@linux.intel.com>
 <20200507110634.2yvzirauq5md7d2q@tomti.i.net-space.pl>
 <d1b55f25-e54c-b259-8836-d834a572de3b@apertussolutions.com>
 <CALCETrVPK=m3F84NtiU59SLyDrBNxi1ONyhH1GuOhx4aGU=_fQ@mail.gmail.com>
 <8c82e8e4-d6bb-7cba-dd32-378dd1c30f3e@apertussolutions.com>
From:   Ross Philipson <ross.philipson@oracle.com>
Autocrypt: addr=ross.philipson@oracle.com; keydata=
 mQENBFtHZ04BCADHhtvMImplKfIEOytU7ZH4haZ9eFAqZpGeIpG9D+pzTCuReM2/49bvgNoI
 e1xuiQFO+UEJ8FjedFjDdqY7fSw3xVdX9gLwD1Rmw0Dadc1w6sGbcoOQLHcglesu+BmcKBtU
 tWQZkzCpEShN4etgZThk8469YnAvO08vNZsrizgrpD90T7mEYiNXxIkX87sPGbnBrL1X7RvZ
 TaRXfE8174W+XVwGEpSiO/GjRgLW8+DFZB5MgXpCR993+U1YT9Lz97/MRzr4hqcOYry6LBYi
 s8dOly4oP7gK15oW8Xap9+ur0Jd8Vy8o99Axq+7yunF+2KE2SwP3/w8H3VDpx7EeDhWDABEB
 AAG0KlJvc3MgUGhpbGlwc29uIDxyb3NzLnBoaWxpcHNvbkBvcmFjbGUuY29tPokBVAQTAQgA
 PgIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBFsN7r6v0OZTCaJ1wdpHdTZHiMYcBQJb
 R2eBBQkJZgGzAAoJENpHdTZHiMYcPYcH/Rlp3/F3P4/2i/W0F4yQDVD6rAkejCws4KlbgC5D
 Slkdvk6j8jOW/HNeIY3n+a3mW0iyyhZlipgYAqkK1loDiDxJjc2eUaHxiYWNLQ4CwIj2EC27
 AWCp6hgwHNWmZrdeNbM/Z6LTFQILx5xzgX+86KNqzFV7gOcAaS2qBVz1D83dgrFZaGaao918
 nvfe+SnImo0GaEf8nVDKgsD2zfzMBkk4q/E0mrEADFXwBHSvNCnVyrCN6Ve0dHWgI7SszUDt
 7v01zbGPR5mRfGuyC9gykd2SDCw5/Q27RMWfaPFL/dtiZBljUzb2yW5jicZAz7zNdDcBSUGR
 r//wxtG4k/dBrMW5AQ0EW0dnTwEIAPelEnLDnfJnHdFR+1Thrvv3Udt/1cjqQfHqH4F8zef/
 MsIcPV1skL7qPUYD+CrbasvmqhlPxtJAtN68inPa70fA2g0PtNmLUH1NBb2e6EjOoVZg9ais
 BWfdYUITZouOXs2zCTFsoNWjTJANnXxexbTf1ZEqfzlVtQK+xAnXl3kiL4Y47VMbgDkGedhw
 3ZMWQ2zMMZqYJkPYhtlTXtedhV91DL1347ULwHsvkUJDZ0gL+WU6tYhsCOOiD61x58PfUiFb
 /WkZEPxb96dSSSWrTlLlBWSSD24RnhfbJjfsXeSu9s4XldmGTDkj7jclMVU1xV0BUfqEwhVn
 xR8FlC+dZvkAEQEAAYkBPAQYAQgAJgIbDBYhBFsN7r6v0OZTCaJ1wdpHdTZHiMYcBQJbR2eB
 BQkJZgGyAAoJENpHdTZHiMYcDIAIAIRJrKjIStRvLsOOCX92s9XJPUjrC/xmtVsqVviyFWIC
 QRPQzDE+bDSvRazudBHmcPW+BOOB5B+p7zKZzOGoZV2peG8oA/Y8oCxOYBtpbBaZ5KJexm/g
 BbnJUwb3uhmKtDShHGUCmtq8MZBJBr6Q6xHprOU8Qnzs9Jea8NVwaz9O226Rrg4XVv/sK1Lh
 ++xZfhi7YqKWdx5vdfdnX1xWe8ma0eXLeCDh3V6Ys+Habw1jEbMuafrcVzAbp1rMt2Lju1ls
 BNAoxeViK7QXWfwGTmGJP++jHmo99gMqEtiohf+37N0oS6uYu6kaE7PxsEcOjWKJxW/DdgwO
 eFq+D6xuiKk=
Message-ID: <7a19dccd-2a07-f852-e49e-e95f087635a0@oracle.com>
Date:   Mon, 1 Jun 2020 14:03:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <8c82e8e4-d6bb-7cba-dd32-378dd1c30f3e@apertussolutions.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9639 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006010134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9639 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1011
 impostorscore=0 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006010135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/20 1:56 PM, Daniel P. Smith wrote:
> On 6/1/20 12:51 PM, Andy Lutomirski wrote:
>> On Mon, Jun 1, 2020 at 8:33 AM Daniel P. Smith
>> <dpsmith@apertussolutions.com> wrote:
>>>
>>> On 5/7/20 7:06 AM, Daniel Kiper wrote:
>>>> Hi Łukasz,
>>>>
>>>> On Tue, May 05, 2020 at 04:38:02PM +0200, Lukasz Hawrylko wrote:
>>>>> On Tue, 2020-05-05 at 01:21 +0200, Daniel Kiper wrote:
>>>
>>> ...
>>>
>>>>> In OS-MLE table there is a buffer for TPM event log, however I see that
>>>>> you are not using it, but instead allocate space somewhere in the
>>>>
>>>> I think that this part requires more discussion. In my opinion we should
>>>> have this region dynamically allocated because it gives us more flexibility.
>>>> Of course there is a question about the size of this buffer too. I am
>>>> not sure about that because I have not checked yet how many log entries
>>>> are created by the SINIT ACM. Though probably it should not be large...
>>>>
>>>>> memory. I am just wondering if, from security perspective, it will be
>>>>> better to use memory from TXT heap for event log, like we do in TBOOT.
>>>>
>>>> Appendix F, TPM Event Log, has following sentence: There are no
>>>> requirements for event log to be in DMA protected memory – SINIT will
>>>> not enforce it.
>>>>
>>>> I was thinking about it and it seems to me that the TPM event log does
>>>> not require any special protections. Any changes in it can be quickly
>>>> detected by comparing hashes with the TPM PCRs. Does not it?
>>>>
>>>
>>> I think it would be beneficial to consider the following in deciding
>>> where the log is placed. There are two areas of attack/manipulation that
>>> need to be considered. The first area is the log contents itself, which
>>> as Daniel has pointed out, the log contents do not really need to be
>>> protected from tampering as that would/should be detected during
>>> verification by the attestor. The second area that we need to consider
>>> is the log descriptors themselves. If these are in an area that can be
>>> manipulated, it is an opportunity for an attacker to attempt to
>>> influence the ACM's execution. For a little perspective, the ACM
>>> executes from CRAM to take the most possible precaution to ensure that
>>> it cannot be tampered with during execution. This is very important
>>> since it runs a CPU mode (ACM Mode) that I would consider to be higher
>>> (or lower depending on how you view it) than SMM. As a result, the txt
>>> heap is also included in what is mapped into CRAM. If the event log is
>>> place in the heap, this ensures that the ACM is not using memory outside
>>> of CRAM during execution. Now as Daniel has pointed out, the down side
>>> to this is that it greatly restricts the log size and can only be
>>> managed by a combination of limiting the number of events and
>>> restricting what content is carried in the event data field.
>>
>> Can you clarify what the actual flow of control is?  If I had to guess, it's:
>>
>> GRUB (or other bootloader) writes log.
>>
>> GRUB transfers control to the ACM.  At this point, GRUB is done
>> running and GRUB code will not run again.
>>
>> ACM validates system configuration and updates TPM state using magic
>> privileged TPM access.
>>
>> ACM transfers control to the shiny new Linux secure launch entry point
>>
>> Maybe this is right, and maybe this is wrong.  But I have some
>> questions about this whole setup.  Is the ACM code going to inspect
>> this log at all?  If so, why?  Who supplies the ACM code?  If the ACM
>> can be attacked by putting its inputs (e.g. this log) in the wrong
>> place in memory, why should this be considered anything other than a
>> bug in the ACM?
> 
> There is a lot behind that, so to get a complete detail of the event
> sequence I would recommend looking at Section Vol. 2D 6.2.3 (pg Vol. 2D
> 6-5/ pdf pg 2531), 6.3 GETSEC[ENTERACCS](pg 6-10 Vol. 2D/pdf pg 2546),
> and 6.3 GETSEC[SENTER](pg Vol. 2D 6-21/pdf pg 2557) in the Intel SDM[1].
> Section 6.2.3 gives a slightly detailed overview. Section
> GETSEC[ENTERACCS] details the requirements/procedures for entering AC
> execution mode and ACRAM (Authenticated CRAM) and section GETSEC[SENTER]
> will detail requirements/procedures for SENTER.
> 
> To answer you additional questions I would say if you look at all the
> work that goes into protecting the ACM execution, why would you want to
> then turn around and have it use memory outside of the protected region.
> On the other hand, you are right, if the Developer's Guide says it
> doesn't need to be protected and someone somehow finds a way to cause a
> failure in the ACM through the use of a log outside of CRAM, then
> rightfully that is a bug in the ACM. This is why I asked about making it
> configurable, paranoid people could set the configuration to use the
> heap and all others could just use an external location.

After thinking about it, it should be easy to make it configurable since
as stated it is up the the pre-launch code to decide where the buffer
is. To do this, the static buffer will be removed from the OS-MLE
structure. In its place there will be two fields:

u64 evt_log_base;
u64 evt_log_size;

If the entity setting up the buffer wants to place the log in the TXT
heap, it simply allocates memory after the OS-MLE fixed structure and
points evt_log_base there. If a buffer outside of the heap is wanted,
just point evt_log_base there. If the MLE wants to determine if the log
is in the TXT heap, it just has to compare evt_log_base to the TXT heap
extents.

Thanks
Ross

> 
>> If GRUB is indeed done by the time anyone consumes the log, why does
>> GRUB care where the log ends up?
> 
> This is because the log buffer allocation was made the responsibility of
> the pre-launch environment, in this case GRUB, and is communicated to
> the ACM via the os_to_mle structure.
> 
>> And finally, the log presumably has nonzero size, and it would be nice
>> not to pin some physical memory forever for the log.  Could the kernel
>> copy it into tmpfs during boot so it's at least swappable and then
>> allow userspace to delete it when userspace is done with it?
>>
> 
> Actually yes we will want to do that because when we move to enabling
> relaunching, an implementation may want to preserve the log from the
> last launch before triggering the new launch which will result in a
> reset of the DRTM PCRs and an overwriting the log.
> 
> [1]
> https://urldefense.com/v3/__https://software.intel.com/sites/default/files/managed/39/c5/325462-sdm-vol-1-2abcd-3abcd.pdf__;!!GqivPVa7Brio!MqL6_Gyu6fCO2MyxrvWmvfkCBRXYv1rKJnUrqvQoMNSwQTA9Db9H9BqDI96S13A4HUA$ 
> 

