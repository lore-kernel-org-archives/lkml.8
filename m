Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2B0C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 14:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7F90206B8
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 14:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgEIOfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 10:35:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:46576 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgEIOfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 10:35:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CB28EACB8;
        Sat,  9 May 2020 14:35:40 +0000 (UTC)
Message-ID: <b540686733f52135b6153a3b4480a25f7f552386.camel@suse.com>
Subject: Re: [RFC PATCH 00/13] Core scheduling v5
From:   Dario Faggioli <dfaggioli@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        vpillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org,
        Alexander Graf <graf@amazon.de>
Date:   Sat, 09 May 2020 16:35:34 +0200
In-Reply-To: <20200414142152.GV20730@hirez.programming.kicks-ass.net>
References: <cover.1583332764.git.vpillai@digitalocean.com>
         <20200414142152.GV20730@hirez.programming.kicks-ass.net>
Organization: SUSE
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-0fT/XSst/21zLV07ZXbd"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0fT/XSst/21zLV07ZXbd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-04-14 at 16:21 +0200, Peter Zijlstra wrote:
> On Wed, Mar 04, 2020 at 04:59:50PM +0000, vpillai wrote:
> >=20
> > - Investigate the source of the overhead even when no tasks are
> > tagged:
> >   https://lkml.org/lkml/2019/10/29/242
>=20
>  - explain why we're all still doing this ....
>=20
> Seriously, what actual problems does it solve? The patch-set still
> isn't
> L1TF complete and afaict it does exactly nothing for MDS.
>=20
Hey Peter! Late to the party, I know...

But I'm replying anyway. At least, you'll have the chance to yell at me
for this during OSPM. ;-P

> Like I've written many times now, back when the world was simpler and
> all we had to worry about was L1TF, core-scheduling made some sense,
> but
> how does it make sense today?
>=20
Indeed core-scheduling alone doesn't even completely solve L1TF. There
are the interrupts and the VMEXITs issues. Both are being discussed in
this thread and, FWIW, my personal opinion is that the way to go is
what Alex says here:

<79529592-5d60-2a41-fbb6-4a5f8279f998@amazon.com>

(E.g., when he mentions solution 4 "Create a "safe" page table which
runs with HT enabled", etc).

But let's stick to your point: if it were only for L1TF, then fine, but
it's all pointless because of MDS. My answer to this is very much
focused on my usecase, which is virtualization. I know you hate us, and
you surely have your good reasons, but you know... :-)

Correct me if I'm wrong, but I think that the "nice" thing of L1TF is
that it allows a VM to spy on another VM or on the host, but it does
not allow a regular task to spy on another task or on the kernel (well,
it would, but it's easily mitigated).

The bad thing about MDS is that it instead allow *all* of that.

Now, one thing that we absolutely want to avoid in virt is that a VM is
able to spy on other VMs or on the host. Sure, we also care about tasks
running in our VMs to be safe, but, really, inter-VM and VM-to-host
isolation is the primary concern of an hypervisor.

And how a VM (or stuff running inside a VM) can spy on another VM or on
the host, via L1TF or MDS? Well, if the attacker VM and the victim VM
--or if the attacker VM and the host-- are running on the same core. If
they're not, it can't... which is basically an L1TF-only looking
scenario.

So, in virt, core-scheduling:
1) is the *only* way (aside from no-EPT) to prevent attacker VM to spy=20
   on victim VM, if they're running concurrently, both in guest mode,
   on the same core (and that's, of course, because with
   core-scheduling they just won't be doing that :-) )
2) interrupts and VMEXITs needs being taken care of --which was the=20
   case already when, as you said "we had only L1TF". Once that is done
   we will effectively prevent all VM to VM and VM to host attack
   scenarios.

Sure, it will still be possible, for instance, for task_A in VM1 to spy
on task_B, also in VM1. This seems to be, AFAIUI, Joel's usecase, so
I'm happy to leave it to him to defend that, as he's doing already (but
indeed I'm very happy to see that it is also getting attention).

Now, of course saying anything like "works for my own usecase so let's
go for it" does not fly. But since you were asking whether and how this
feature could make sense today, suppose that:
1) we get core-scheduling,
2) we find a solution for irqs and VMEXITs, as we would have to if=20
   there was only L1TF,
3) we manage to make the overhead of core-scheduling close to zero=20
   when it's there (I mean, enabled at compile time) but not used (I
   mean, no tagging of tasks, or whatever).

That would mean that virt people can enable core-scheduling, and
achieve good inter-VM and VM-to-host isolation, without imposing
overhead to other use cases, that would leave core-scheduling disabled.

And this is something that I would think it makes sense.

Of course, we're not there... because even when this series will give
us point 1, we will also need 2 and we need to make sure we also
satisfy 3 (and we weren't, last time I checked ;-P).

But I think it's worth keeping trying.

I'd also add a couple of more ideas, still about core-scheduling in
virt, but from a different standpoint than security:
- if I tag vcpu0 and vcpu1 together[*], then vcpu2 and vcpu3 together,
  then vcpu4 and vcpu5 together, then I'm sure that each pair will
  always be scheduled on the same core. At which point I can define
  an SMT virtual topology, for the VM, that will make sense, even
  without pinning the vcpus;
- if I run VMs from different customers, when vcpu2 of VM1 and vcpu1
  of VM2 run on the same core, they influence each others' performance.
  If, e.g., I bill basing on time spent on CPUs, it means customer
  A's workload, running in VM1, may influence the billing of customer
  B, who owns VM2. With core scheduling, if I tag all the vcpus of each
  VM together, I won't have this any longer.

[*] with "tag together" I mean let them have the same tag which, ATM
would be "put them in the same cgroup and enable cpu.tag".

Whether or not these make sense, e.g., performance wise, it's a bid
hard to tell, with the feature not-yet finalized... But I've started
doing some preliminary measurements already. Hopefully, they'll be
ready by Monday. =20

So that's it. I hope this gives you enough material to complain about
during OSPM. At least, given the event is virtual, I won't get any
microphone box (or, worse, frozen sharks!) thrown at me in anger! :-D

Regards
--=20
Dario Faggioli, Ph.D
http://about.me/dario.faggioli
Virtualization Software Engineer
SUSE Labs, SUSE https://www.suse.com/
-------------------------------------------------------------------
<<This happens because _I_ choose it to happen!>> (Raistlin Majere)


--=-0fT/XSst/21zLV07ZXbd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEES5ssOj3Vhr0WPnOLFkJ4iaW4c+4FAl62v7YACgkQFkJ4iaW4
c+5OzhAAvuTINOolLElkcNa6CPIiwJ2I12+Lz+NCpF/WrIqDOJZor304nZtDhabh
pV/XaVzTWqj5zQndPqdZEVzXPKMnfp6d0r9Yb0Du2ckwvifVeM8VmmIFOMOmvaHC
DSM0ocsdoNp/gviFKtrLbzIAxVK24DmKrBccWtK7r8kjL3Thccod/KT9UjzdHIXy
xIp/jxPvkZ4+ekPWfYUCcDXiSSshPcGJQ+EGK/LAEQ9k8RgdkQY76rEY1VU9esEn
IZ4U3jvR1cmDTzeSJWfxlRvRUsiMNSvfmh/xkvM8wV8VbvaPvkndGTmxLzJc7ceb
abnpv7AClaCthh2xdqvion4vxO9syoE4zB1hXxAVmvPVCMwxrxg3pBS8BmENACo8
b7Sa9W07ZPCzRn6hkw62jGCda/yjlcfNY9c6yiPlCSG2akshrwFOYUH8GWrSX/k7
5/FjHJKM+CPqGfQdQX1H6/VdhBO6i2Wc0SvOk3w1L11awDA6ZpMG8BLRrXtpnBSl
IO7AaNW1H2WuQfbDEyiAfO+zHhvQXIeg0ra1BpCcJfgoknXQDSCSAf3MHF4vEzgr
hY9PuomPVBYu8gFvB78B8w1O2vwoKuzTsmHNmEQ1IaNzYBmgHieis9sMAYUDleWD
aqdZabRXG+XuPgnMxKT8qcsQpiF3JQAEi+iRrP8Vi6d2Ss+L1VQ=
=6kqy
-----END PGP SIGNATURE-----

--=-0fT/XSst/21zLV07ZXbd--

